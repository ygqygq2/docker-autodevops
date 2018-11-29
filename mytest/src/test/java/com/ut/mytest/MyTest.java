package com.ut.mytest;

import com.ut.test.TestApp;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import javax.validation.constraints.AssertTrue;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = TestApp.class,
        webEnvironment = SpringBootTest.WebEnvironment.MOCK
//        , properties = {"spring.profiles.active=test"}
)
@AutoConfigureMockMvc
public class MyTest {
     @Autowired
    private MockMvc mockMvc;
    @Test
    public void testAddAreaTree() throws Exception{
        //get
        MockHttpServletResponse mockHttpServletResponse = mockMvc.perform(
                get("/")
                        .accept(MediaType.APPLICATION_JSON)
                        .contentType(MediaType.APPLICATION_FORM_URLENCODED)
                        .param("param", "healthz")
        ).andDo(print()).andReturn().getResponse();

         Assert.assertEquals(mockHttpServletResponse.getContentAsString(),("hello:healthz"));
    }
}
