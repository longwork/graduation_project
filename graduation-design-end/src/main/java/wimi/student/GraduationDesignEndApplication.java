package wimi.student;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import tk.mybatis.spring.annotation.MapperScan;

/**
 * @author 17495
 */
@Controller
@EnableWebMvc
@SpringBootApplication
@MapperScan(basePackages = "wimi.student.mapper")
public class GraduationDesignEndApplication extends WebMvcConfigurerAdapter implements CommandLineRunner {
    //@EnableWebMvc 快捷配置Spring Webmvc的一个注解。

    private static final Logger logger = LoggerFactory.getLogger(GraduationDesignEndApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(GraduationDesignEndApplication.class, args);
    }


    @Override
    public void run(String... args) throws Exception {
        logger.info("服务启动完成");
    }

    @RequestMapping("/")
    public String home() {
        return "login";
    }
}
