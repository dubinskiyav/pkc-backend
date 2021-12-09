package biz.gelicon.core.controllers.admin;

import biz.gelicon.core.config.Config;
import org.junit.jupiter.api.BeforeEach;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

@SpringBootTest
@AutoConfigureMockMvc
@WebAppConfiguration
public class IntergatedTest {
    static public Logger logger = LoggerFactory.getLogger(IntergatedTest.class);

    public MockMvc mockMvc;

    @Autowired
    ApplicationContext applicationContext;

    @Autowired
    WebApplicationContext webApplicationContext;

    static boolean start = false;

    protected static String token;

    @BeforeEach
    void beforeRunTest() {
        mockMvc = MockMvcBuilders
                .webAppContextSetup(webApplicationContext)
                .build();
        if(!start) {
            onStart();
            start = true;
        }
    }

    protected void onStart() {

    }

    protected String buildUrl(String uri) {
        return "/v" + Config.CURRENT_VERSION + uri;
    }

    protected String buildUrl(String uri, String contoure, String module) {
        return "/v" + Config.CURRENT_VERSION + "/apps/" + contoure + "/" + module + "/" + uri;
    }

    protected String buildUrl(String uri, String contoure) {
        return "/v"+ Config.CURRENT_VERSION+"/apps/"+contoure+"/"+uri;
    }

}
