package uaiContacts.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import uaiContacts.model.Employee;

public interface EmployeeRepository extends PagingAndSortingRepository<Employee, Integer> {
    Page<Employee> findByNameLike(Pageable pageable, String name);
}