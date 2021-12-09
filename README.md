## Подключение отчетов для запуска из Idea

Проект с отчетами располагается в каталоге `../reports`. Для отладки работы отчетов из IDE 
необходимо установить зависимость от отчетов

 1. Нажать `Ctrl+Alt+Shift+S` или меню `Project Structure...`
 2. Выбрать `Project Settings/Modules`
 3. В правой части экрана найти модуль `gelicon-core`.
 4. Перейти на вкладку `Dependencies` и нажать на **`+`** `(Add)`
 5. Выбрать `Jars and directories...`
 6. Найти и выбрать `../reports/assembly/target/reports.jar`
 7. Если его нет, то найти в каталоге `../reports/` файл  `build.cmd` и с помощью него 
 выполнить сборку `reports.jar`. Повторить 1-6.
 8. Выполнить 1-6 по отношению к каталогу `../reports/assembly/target/lib`
 
 Пункты 1-8 могут не потребоваться, если файл gelicon.core.iml взят 
 из репозитория и проект с печатными формами расположен в `../reports`  
 
## Подключение отчетов к продуктиву
 
 1. В каталоге, где расположен исполняемый `gelicon-core-0.0.1-SNAPSHOT.jar`, 
 создать каталог `lib`
 2. В `lib` положить готовый `reports.jar` и каталог lib 
 из `../reports/assembly/target/`
 3. Перезапустить `gelicon-core-0.0.1-SNAPSHOT.jar`

Результат должен выглядеть следующим образом
 ```
 [-] lib
    [+] lib
    reports.jar
 gelicon-core-0.0.1-SNAPSHOT.jar
```
## Подключение артефактов для запуска из Idea

Сборка artifact.jar

Колнировать проект artifact командой

git clone https://git.srv.gelicon.biz/gelicon-core/artifact.git

в той же папке, что и проект gelicon-core

Выполнить сборку проекта 

D:\java\apache-maven-3.8.1\bin\mvn.cmd  clean package

Путь к mvn.cmd может отличаться

Для удобства можно сделать файл
build.cmd
SET JAVA_HOME=D:\java\jdk-11
D:\java\apache-maven-3.8.1\bin\mvn.cmd  clean package

Результат 
Building jar: D:\WORK\Programming\gelicon-core\artifact\target\artifact-1.0-SNAPSHOT.jar


Для отладки работы отчетов в проекте gelicon-core в IntelliJ IDE 
необходимо установить зависимость

 1. Нажать `Ctrl+Alt+Shift+S` или меню `Fule-Project Structure...`
 2. Выбрать `Project Settings/Modules`
 3. В средней части найти модуль `gelicon-core`.
 4. Перейти на вкладку `Dependencies` и нажать на **`+`** `(Add)`
 5. Выбрать `Jars and directories...`
 6. Найти и выбрать `../artifact/target/artifact-1.0-SNAPSHOT.jar`
 7. Если его нет, то выполнить Сборка artifact.jar. Повторить 1-6.
 
 Пункты 1-7 могут не потребоваться, если файл gelicon.core.iml взят 
 из репозитория и проект с печатными формами расположен в `../reports`  
 
## Подключение артефактов к продуктиву
 
 1. В каталоге, где расположен исполняемый `gelicon-core-0.0.1-SNAPSHOT.jar`, 
 создать каталог `lib`
 2. В `lib` положить готовый `artifact.jar` 
 3. Перезапустить `gelicon-core-0.0.1-SNAPSHOT.jar`


## Отключение Annotation Processor
 
Для версии IntelliJ IDEA Communiti Edition возможно потребуется отключить Annotation Processor
В случае возникновения следующей ошибки при попытке собрать проект

```
java: Attempt to reopen a file for path .../gelicon-core/backend/target/test-classes/META-INF/services/biz.gelicon.artifacts.ArtifactService
```
надо вызвать меню:
File/Setting/Setting/Build.../Compiler/Annotation Processor и снять флаг с "Enable annotation processing"

   