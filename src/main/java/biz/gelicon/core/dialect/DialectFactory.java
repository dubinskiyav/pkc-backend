package biz.gelicon.core.dialect;

import biz.gelicon.core.MainApplication;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DialectFactory {

    public static final String SPRING_DATASOURCE_HIKARI_SCHEMA = "spring.datasource.hikari.schema";

    public enum DatabaseType {
        NONE,
        POSTGRESQL,
        ORACLE,
        SQLSERVER,
        MYSQL,
        FIREBIRD,
        FIREBIRD25
    }

    static private DBDialect dialect;
    static private DatabaseType dbType = DatabaseType.NONE;

    public static DBDialect getDialect() {
        if (dialect == null) {
            DataSource ds = MainApplication.getApplicationContext().getBean(DataSource.class);
            String url = getConnectionUrl(ds);

            if (url.startsWith("jdbc:postgresql")) {
                String schema = MainApplication.getApplicationContext().getEnvironment()
                        .getProperty(SPRING_DATASOURCE_HIKARI_SCHEMA);
                dialect = new PostgreDialect(schema == null ? "dbo" : schema);
                dbType = DatabaseType.POSTGRESQL;
            } else if (url.startsWith("jdbc:firebirdsql")) {
                Boolean isFirebirdsql25 = false;
                try {
                    isFirebirdsql25 = (Boolean) MainApplication.getApplicationContext()
                            .getBean("isFirebirdsql25");
                } catch (Exception e) {
                }
                if (!isFirebirdsql25) {
                    dialect = new FireBirdDialect();
                    dbType = DatabaseType.FIREBIRD;
                } else {
                    dialect = new FireBirdDialect25();
                    dbType = DatabaseType.FIREBIRD25;
                }
            } else {
                throw new RuntimeException(String.format("Unknown database type by uri %s", url));
            }
        }
        return dialect;
    }

    private static String getConnectionUrl(DataSource ds) {
        try (Connection con = ds.getConnection()) {
            return con.getMetaData().getURL();
        } catch (SQLException ex) {
            throw new RuntimeException(ex.getMessage(), ex);
        }
    }

    public static DatabaseType getDatabaseType() {
        return dbType;
    }

}
