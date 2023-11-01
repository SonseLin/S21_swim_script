# S21_swim_script
Personal script for peers at School 21 for *unix systems (Linux / MacOS)

**Write to install the command below**

***curl -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/.zshrc > ~/.bashrc ; source ~/.bashrc ; init_setup***

**NR**       - get the last stable release

**info_bas** - simple view contents branch name and directory

**info_ext** - extended view with userdata

**restart**  - restart terminal if something unexpected happened

**comp**     - accept *.c file and compiles it with all flags checked & running at the same time

**set_color** - Меняет цвет вывода. Доступные опции git(меняет цвет ветки), cnt(меняет цвет информации о пользователе) и path(меняет цвет директории).
Доступные опции цвета на выбор: blue, red, green, yellow, purple, cyan

**clang_check** - проверяет .c файл на соответствие стилевым нормам школы

**clang_fix**   - правит .c файл по стилевым нормам школы

**Example of terminal view with extended view for userdata**

![terminal_screen](scr1.png)

**To delete use following command**

rm ~/.zshrc
