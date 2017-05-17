# sonarqube 설정 관련

# mariadb 설치 -> mysql 로 변경 mariadb 지원안됨..
# mariadb docker 설치
# 기본 실행
# docker run --name mariadb -p 3406:3306 -e MYSQL_ROOT_PASSWORD=maria123 -d mariadb
docker run --name mysql -p 3406:3306 -e MYSQL_ROOT_PASSWORD=mysql123 -d mysql

# mariadb host conf set
# docker run --name mariadb -v /var/mysql/conf.d:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=maria123 mariadb
# docker run --name mysql -v /var/mysql/conf.d:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=mysql123 mysql

# mariadb vulume <-- 사용
# docker run --name mariadb -p 3306:3306 -v /var/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=maria123 -d mariadb
# docker run --name mysql -p 3306:3306 -v /var/mysql2/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mysql123 -d mysql

# mariadb command mysqladmin
docker run -it --link mariadb:mysql --rm mariadb sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
docker run -it --link mysql:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
docker run -it --link mysql:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'

# database  생성
# CREATE DATABASE sonarqube CHARACTER SET utf8 COLLATE utf8_general_ci;

# 사용자 추가 - sonarqube db에 권한 부여 하고 어디서든 접근, sonarqube 사용자추가하고 sonarqube라는 패스워드 부여
# GRANT ALL PRIVILEGES ON sonarqube.* TO sonarqube@'%' IDENTIFIED BY 'sonarqube';
# GRANT ALL PRIVILEGES ON sonarqube.* TO sonarqube@'localhost' IDENTIFIED BY 'sonarqube';

# 적용
FLUSH PRIVILEGES;

CREATE DATABASE sonarqube CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'sonarqube' IDENTIFIED BY 'sonarqube';
GRANT ALL ON sonarqube.* TO 'sonarqube'@'%' IDENTIFIED BY 'sonarqube';
GRANT ALL ON sonarqube.* TO 'sonarqube'@'localhost' IDENTIFIED BY 'sonarqube';
FLUSH PRIVILEGES;

sonarqube 설치
https://hub.docker.com/r/library/sonarqube/
# docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 -v /var/data/sonarqube:/opt/sonarqube sonarqube

# 외부 open port는 3406으로 했지만 내부 --linke 옵션으로 연결할 경우 내부 3306으로 포트 적용
docker run -d --name sonarqube \
    -v /var/data/sonarqube/data:/opt/sonarqube/data \
    -v /var/data/sonarqube/extensions:/opt/sonarqube/extensions \
    -v /var/data/sonarqube/lib/bundled-plugins:/opt/sonarqube/lib/bundled-plugins \
    -p 9000:9000 -p 9092:9092 \
    --link mysql:mysql \
    -e SONARQUBE_JDBC_USERNAME=sonarqube \
    -e SONARQUBE_JDBC_PASSWORD=sonarqube \
    -e SONARQUBE_JDBC_URL='jdbc:mysql://mysql:3306/sonarqube?useUnicode=true&characterEncoding=utf8&useSSL=false' \
    -e SONARQUBE_WEB_JVM_OPTS='-Xms2048m -Xmx2048m' \
    sonarqube

# browser open
# login : admin / admin

# maven 연동 참고
# http://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner+for+Maven 

# plugin 설치
# 언어 선택 : 
java, javascript, jsp
# 코드 검사 : 
findbug, PMD CheckStyle
# 코드 커버리지 : 
cobertura (java 1.7 이상 지원이 제대로 안됨.) last update 2015.01월
jacoco
# 한글언어팩 : https://github.com/SonarQubeCommunity/sonar-l10n-ko
# views : http://www.sonarsource.com/products/plugins/governance/

#########
jenkins plugin
sonar
FindBugs Plug-in
JaCoCo plugin
##########

######
jacoco 
junit test code Coverage : target/jacoco.exec



<settings>
    <pluginGroups>
        <pluginGroup>org.sonarsource.scanner.maven</pluginGroup>
    </pluginGroups>
    <profiles>
        <profile>
            <id>sonar</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <properties>
                <!-- Optional URL to server. Default value is http://localhost:9000 -->
                <sonar.host.url>
                  http://gwtms.gridwiz.com:84
                </sonar.host.url>
                <sonar.login>admin</sonar.login>
                <sonar.password>admin</sonar.password>
            </properties>
        </profile>
     </profiles>
</settings>

========실행=========
mvn clean dependency-check:check
mvn clean verify sonar:sonar

// -Dmaven.test.failure.ignore=true 이면 그냥 unit test 검증 통과 false 이면 실패
mvn clean -Dmaven.test.failure.ignore=false dependency-check:check verify sonar:sonar

mvn clean dependency-check:check verify sonar:sonar

==================================
운영
pre
mvn clean verify sonar:sonar

build
clean package -DskipTests=true docker:build -DpushImageTag

post
docker rmi $(docker images | grep gwlab/crocus_api | awk '{print $1":"$2}')

new
clean dependency-check:check verify sonar:sonar 
==================================

=======사용오류해결 ================
org.apache.ibatis.exceptions.TooManyResultsException: Expected one result (or null) to be returned by selectOne(), but found: 2
        at org.apache.ibatis.session.defaults.DefaultSqlSession.selectOne(DefaultSqlSession.java:70) ~[mybatis-3.2.7.jar:3.2.7]
        at org.apache.ibatis.binding.MapperMethod.execute(MapperMethod.java:68) ~[mybatis-3.2.7.jar:3.2.7]
        at org.apache.ibatis.binding.MapperProxy.invoke(MapperProxy.java:52) ~[mybatis-3.2.7.jar:3.2.7]
        at com.sun.proxy.$Proxy57.selectDefaultProfile(Unknown Source) ~[na:na]
        at org.sonar.db.qualityprofile.QualityProfileDao.selectDefaultProfile(QualityProfileDao.java:184) ~[sonar-db-6.0.jar:na]

해결 :  rules_profiles 테이블에서 is_default 필드의 1 값이 1개만 있어야 한다.

=========
service docker stop && start 실행 시 docker container의 모든 프로세스들을 중지 시키고 한다.
안그러면 host와 충돌생겨 docker 실행이 안될 수 있음


===========
sonarqube 특징
좀더 고급 플러그인을 사용하려면 license를 사야함..
report 같은 것들..
http://www.sonarsource.com/products/editions/


## sonarqube pom.xml
```
<plugin>
    <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
    <version>0.7.7.201606060606</version>
    <executions>
        <execution>
            <id>prepare-unit-tests</id>
            <goals>
                <goal>prepare-agent</goal>
            </goals>
        </execution>
        <execution>
            <id>prepare-integration-tests</id>
            <goals>
                <goal>prepare-agent-integration</goal>
            </goals>
        </execution>
        <execution>
            <id>default-report</id>
            <goals>
                <goal>report</goal>
            </goals>
        </execution>
        <execution>
            <id>default-report-integration</id>
            <goals>
                <goal>report-integration</goal>
            </goals>
        </execution>
        <execution>
            <id>default-check</id>
            <goals>
                <goal>check</goal>
            </goals>
            <configuration>
                <rules>
                    <rule>
                    <element>BUNDLE</element>
                    <limits>
                    <limit>
                    <counter>COMPLEXITY</counter>
                    <value>COVEREDRATIO</value>
                    <minimum>0.60</minimum>
                    </limit>
                    </limits>
                    </rule>
                    <rule>
                        <element>CLASS</element>
                        <excludes>
                            <exclude>*Test</exclude>
                        </excludes>
                        <limits>
                            <limit>
                                <counter>LINE</counter>
                                <value>COVEREDRATIO</value>
                                <minimum>0.00</minimum>
                            </limit>
                        </limits>
                    </rule>
                </rules>
            </configuration>
        </execution>
    </executions>
</plugin>
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>2.17</version>
</plugin>
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-failsafe-plugin</artifactId>
    <version>2.19.1</version>
    <executions>
        <execution>
            <id>default-integration-test</id>
            <goals>
                <goal>integration-test</goal>
                <goal>verify</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

## rule 및 profile 설정

custom 할 profile을 생성 후 rule정보에서 repository 중 profile rule에 추가할 정보들을 활성화 한다.
(예: findbug, findbug security, PMD, checkstyle 등)

## owasp top 10 plugin
https://github.com/stevespringett/dependency-check-sonar-plugin
