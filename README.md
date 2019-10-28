# XRayExtensions
Рус.
Проект XRayExtensions представляет себе расширения и исправления кода оригинального движка XRay с использованием ассемблерных правок.
Дополнительный код размещается в новой секции, первоначально была только одна секция, где размещался как код, так и данные.
В более новых ревизиях, кроме кодовой секции (MyCode), добавлены 2 секции данных, секция (MyConst) - где размещены константные данные 
(только чтение), и (MyData) где размещены изменяемые данные (чтение и запись). Основная секция меняется (пропатчивается) по адресам
указанными в файле corrections_list.txt
Этот проект основан на ревизии 232 от Макрона.
Так же смотрите файл readme_portable.txt

Eng.
The XRayExtensions project represents extensions and code corrections of the original XRay engine using assembler edits.
Additional code is placed in the new section, originally there was only one section where both code and data were placed.
In newer revisions, in addition to the code section (MyCode), 2 data sections were added, the section (MyConst) - where constant data is placed 
(read only), and (MyData) where the mutable data is placed (read and write). The main section is changed (patched) by addresses
specified in the corrections_list file.txt
This project is based on revision 232 from Macron.
Also see the readme_portable file.txt
