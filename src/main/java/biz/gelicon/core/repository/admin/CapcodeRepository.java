package biz.gelicon.core.repository.admin;

import biz.gelicon.core.model.admin.Capcode;
import biz.gelicon.core.repository.TableRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CapcodeRepository implements TableRepository<Capcode> {

    private static final Logger logger = LoggerFactory.getLogger(CapcodeRepository.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void create() {
        // созданы в common
    }

    @Override
    public void dropForTest() {
        // удаляются в common_drop
    }

    @Override
    public int load() {
        //в common
        return 0;
    }

}

