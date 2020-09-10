## Several Variable for Tmux Configuration
### About Time
| String | Meaning                | Example       |
| :----: | ---------------------- | ------------- |
| %a     | Day of week            | Fri           |
| %A     | Day of week Expanded   | Friday        |
| %b     | Month                  | Sep           |
| %d     | Day                    | 11            |
| %Y     | Year                   | 2020          |
| %D     | Month/Day/Year         | 09/11/2020    |
| %v     | Day-Month-Year         | 11-Sep-2020   |
| %r     | Hour:Min:Sec AM/PM     | 02:43:53 PM   |
| %T     | 24 Hour:Min:Sec        | 14:43:53      |
| %X     | Hour:Min:Sec           | 02:43:53      |
| %R     | 24 Hour:Min            | 14:43         |
| %H     | 24 Hour                | 14            |
| %l     | Hour                   | 02            |
| %M     | Mins                   | 43            |
| %S     | Seconds                | 53            |
| %p     | AM/PM                  | PM            |

### About Runtime
| String   | Meaning                                 | Example            |
| -------- | --------------------------------------- | ------------------ |
| #D       |                                         |                    |
| #F       |                                         |                    |
| #H       | Hostname                                | festivo            |
| #I       | Window index                            | 0                  |
| #P       |                                         |                    |
| #S       | session index                           |                    |
| #T       | Pane title or current running command   | vim ~/.tmux.conf   |
| #W       | Window title or current task name       | vim                |

### Colour
Bash command for showing 256-colors
```sh
for i in {0..255} ; do
    printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
    if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
        printf "\n";
    fi
done
```
