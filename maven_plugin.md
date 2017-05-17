#maven plugin 설정 종류


## war 압축 설정

```
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-war-plugin</artifactId>
	<configuration>
		<packagingIncludes>resource/**,surefire-reports/**/*,META-INF/**,WEB-INF/classes/**,WEB-INF/lib/**,WEB-INF/views/**,/*.*</packagingIncludes>
    	<failOnMissingWebXml>false</failOnMissingWebXml>
    	<webappDirectory>WebContent</webappDirectory>
    	<warSourceDirectory>${basedir}/WebContent</warSourceDirectory>
    	<!-- <outputDirectory>${basedir}/WebContent</outputDirectory> -->
	</configuration>
</plugin>
```

## jar 압축 설정

```
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-jar-plugin</artifactId>
    <configuration>
        <finalName>${jar.name}</finalName>
        <includes>
        	<include>src/main/webapp</include>
      	</includes>
        <!-- jar 파일이 생성될 폴더 -->
        <outputDirectory>${deploy.target.dir}</outputDirectory>
        <!-- 
        <archive>
            <manifest>
                !-- public static void main() 함수가 있는 클래스 지정 --
                <mainClass>com.publicsafety.esmc.PublicSafetyApplication</mainClass>
                <!-- jar 파일 META-INF/MANIFEST.MF 에 클래스패스 정보 추가 -->
                <addClasspath>true</addClasspath>                
                <!--
                    	클래스패스에 추가시 prefix 설정 ex) log4j-1.2.16.jar -> lib/log4j-1.2.16.jar 로 추가됨
                -->
                <classpathPrefix>${lib.dir}/</classpathPrefix>
            </manifest>
        </archive>
         -->
    </configuration>
</plugin>
```


## package 실행할때 프로젝트 디펜던시들을 특정폴더로 복사해주게 설정

```
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-dependency-plugin</artifactId>
    <executions>
        <execution>
            <id>copy-dependencies</id>
            <phase>package</phase>
            <goals>
                <goal>copy-dependencies</goal>
            </goals>
        </execution>
    </executions>
    <configuration>
        <outputDirectory>${deploy.target.dir}/${lib.dir}</outputDirectory>
        <overWriteIfNewer>true</overWriteIfNewer>
    </configuration>
</plugin>
```

## resource 정보 설정

```
<plugin>
    <artifactId>maven-resources-plugin</artifactId>
    <executions>
      <execution>
        <id>copy-resources</id>
        <!-- here the phase you need -->
        <phase>validate</phase>
        <goals>
          <goal>copy-resources</goal>
        </goals>
        <configuration>
          <outputDirectory>src/main/resources/META-INF/resources</outputDirectory>
          <resources>          
            <resource>
              <directory>src/main/webapp/WEB-INF/jsp</directory>
              <filtering>true</filtering>
            </resource>
          </resources>              
        </configuration>            
      </execution>
    </executions>
  </plugin>
```

## unit test 설정
### 속성 : -Dmaven.test.failure.ignore=true -Dmaven.test.skip=true

```
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>2.17</version>
</plugin>
```

## maven-failsafe-plugin(maven-surefire-plugin 는 통합테스트가 되지 않아 이걸 사용하는게 좋음)

```
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

## owasp top 10 plugin
https://github.com/stevespringett/dependency-check-sonar-plugin
