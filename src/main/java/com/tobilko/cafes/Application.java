package com.tobilko.cafes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tobilko.cafes.cafe.Cafe;
import com.tobilko.cafes.cafe.CafeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Controller
@SpringBootApplication
public class Application {

    @Autowired
    public Application(CafeRepository repository) {this.repository = repository;}

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    public FreeMarkerViewResolver freemarkerViewResolver() {
        FreeMarkerViewResolver resolver = new FreeMarkerViewResolver();

        resolver.setCache(true);
        resolver.setPrefix("");
        resolver.setSuffix(".ftl");

        return resolver;
    }

    private final CafeRepository repository;

    @GetMapping(path = "/")
    public String getCafes(@ModelAttribute("model") ModelMap model, ObjectMapper mapper) throws JsonProcessingException {

        List<Cafe> target = new ArrayList<>();
        repository.findAll().forEach(target::add);


        String cafesJson = mapper.writer().withDefaultPrettyPrinter().writeValueAsString(target);

        model.addAttribute("cafes", cafesJson);
        return "index";
    }

    @PostMapping(path = "/create")
    public String createCafe(Cafe cafe)  {
        repository.save(cafe);

        return "redirect:/";
    }


    @PostMapping(path = "/remove")
    public String remove(Cafe cafe) {
        repository.deleteById(cafe.getId());

        return "redirect:/";
    }

    @PostMapping(path = "/edit")
    public String edit(Cafe cafe) {
        repository.save(cafe);

        return "redirect:/";
    }

    @Bean
    public CommandLineRunner demo(CafeRepository repository) {
        return (args) -> {
            repository.save(new Cafe(-25.363882, 131.044922, "Andrew's Cafe", "the best one", "=2384230984823904", "34-43-"));
            repository.save(new Cafe(-0.63437, -165.47581, "Kolya's Cafe", "the worst one", "=2384230984823904", "34-43-"));
        };
    }

}
