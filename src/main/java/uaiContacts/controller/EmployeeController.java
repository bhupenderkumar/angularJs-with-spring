package uaiContacts.controller;

import java.util.Locale;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import uaiContacts.model.Employee;
import uaiContacts.service.EmployeeService;
import uaiContacts.vo.EmployeeListVO;

@Controller
@RequestMapping(value = "/protected/employees")
public class EmployeeController {

	private static final String DEFAULT_PAGE_DISPLAYED_TO_USER = "0";

	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private MessageSource messageSource;

	@Value("5")
	private int maxResults;

	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView welcome() {
		return new ModelAndView("employeeList");
	}

	@RequestMapping(method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<?> listAll(@RequestParam int page, Locale locale) {
		return createListAllResponse(page, locale);
	}

	@RequestMapping(method = RequestMethod.POST, produces = "application/json")
	public ResponseEntity<?> create(
			@ModelAttribute("employee") Employee employee,
			@RequestParam(required = false) String searchFor,
			@RequestParam(required = false, defaultValue = DEFAULT_PAGE_DISPLAYED_TO_USER) int page,
			Locale locale) {
		System.out.println("Employee " + employee.toString());
		employeeService.save(employee);

		if (isSearchActivated(searchFor)) {
			return search(searchFor, page, locale, "message.create.success");
		}

		return createListAllResponse(page, locale, "message.create.success");
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT, produces = "application/json")
	public ResponseEntity<?> update(
			@PathVariable("id") int contactId,
			@RequestBody Employee employee,
			@RequestParam(required = false) String searchFor,
			@RequestParam(required = false, defaultValue = DEFAULT_PAGE_DISPLAYED_TO_USER) int page,
			Locale locale) {
		if (contactId != employee.getId()) {
			return new ResponseEntity<String>("Bad Request",
					HttpStatus.BAD_REQUEST);
		}

		employeeService.save(employee);

		if (isSearchActivated(searchFor)) {
			return search(searchFor, page, locale, "message.update.success");
		}
		return createListAllResponse(page, locale, "message.update.success");
	}

	@RequestMapping(value = "/{employeeId}", method = RequestMethod.DELETE, produces = "application/json")
	public ResponseEntity<?> delete(
			@PathVariable("employeeId") int employeeId,
			@RequestParam(required = false) String searchFor,
			@RequestParam(required = false, defaultValue = DEFAULT_PAGE_DISPLAYED_TO_USER) int page,
			Locale locale) {

		try {
			employeeService.delete(employeeId);
		} catch (AccessDeniedException e) {
			return new ResponseEntity<Object>(HttpStatus.FORBIDDEN);
		}

		if (isSearchActivated(searchFor)) {
			return search(searchFor, page, locale, "message.delete.success");
		}

		return createListAllResponse(page, locale, "message.delete.success");
	}

	@RequestMapping(value = "/{name}", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<?> search(
			@PathVariable("name") String name,
			@RequestParam(required = false, defaultValue = DEFAULT_PAGE_DISPLAYED_TO_USER) int page,
			Locale locale) {
		return search(name, page, locale, null);
	}

	private ResponseEntity<?> search(String name, int page, Locale locale,
			String actionMessageKey) {
		EmployeeListVO employeeListVO = employeeService.findByNameLike(page,
				maxResults, name);

		if (!StringUtils.isEmpty(actionMessageKey)) {
			addActionMessageToVO(employeeListVO, locale, actionMessageKey, null);
		}

		Object[] args = { name };

		addSearchMessageToVO(employeeListVO, locale,
				"message.search.for.active", args);

		return new ResponseEntity<EmployeeListVO>(employeeListVO, HttpStatus.OK);
	}

	private ResponseEntity<?> createListAllResponse(int page, Locale locale) {
		return createListAllResponse(page, locale, null);
	}

	private EmployeeListVO listAll(int page) {
		return employeeService.findAll(page, maxResults);
	}

	private ResponseEntity<?> createListAllResponse(int page, Locale locale,
			String messageKey) {
		EmployeeListVO employeeListVO = listAll(page);

		addActionMessageToVO(employeeListVO, locale, messageKey, null);

		return returnListToUser(employeeListVO);
	}

	private EmployeeListVO addActionMessageToVO(EmployeeListVO employeeListVO,
			Locale locale, String actionMessageKey, Object[] args) {
		if (StringUtils.isEmpty(actionMessageKey)) {
			return employeeListVO;
		}

		employeeListVO.setActionMessage(messageSource.getMessage(
				actionMessageKey, args, null, locale));

		return employeeListVO;
	}

	private ResponseEntity<EmployeeListVO> returnListToUser(
			EmployeeListVO employeeListVO) {
		return new ResponseEntity<EmployeeListVO>(employeeListVO, HttpStatus.OK);
	}

	private EmployeeListVO addSearchMessageToVO(EmployeeListVO employeeListVO,
			Locale locale, String actionMessageKey, Object[] args) {
		if (StringUtils.isEmpty(actionMessageKey)) {
			return employeeListVO;
		}

		employeeListVO.setSearchMessage(messageSource.getMessage(
				actionMessageKey, args, null, locale));

		return employeeListVO;
	}

	private boolean isSearchActivated(String searchFor) {
		return !StringUtils.isEmpty(searchFor);
	}
}
