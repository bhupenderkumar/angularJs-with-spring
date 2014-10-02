package uaiContacts.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import uaiContacts.model.User;
import uaiContacts.service.UserService;

@Controller
@RequestMapping("/registration")
public class RegistrationController {

	@Autowired
	UserService userService;
	
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.DELETE, RequestMethod.PUT})
    public ModelAndView doGet() {
        return new ModelAndView("registration");
    }
    
    @RequestMapping(method = RequestMethod.POST)
    public ModelAndView register(@ModelAttribute("user") User user) {
    	//System.out.println("User : "+user);
    	userService.register(user);
    	return new ModelAndView("login");
    }
}
