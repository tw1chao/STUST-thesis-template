# Container

您可以參考 [docker](https://www.docker.com/) 或 [podman](https://podman.io/).

## 安裝

### docker engine
* [Windows install](https://docs.docker.com/desktop/windows/install/)
* [Mac OS install](https://docs.docker.com/desktop/mac/install/)
* [Ubuntu install](https://docs.docker.com/engine/install/ubuntu/)

### podman engine
* [Podman GUI](https://podman-desktop.io/downloads)
* [Podman Github Releases page](https://github.com/containers/podman/releases)

[Remove all unused pods, containers, images, networks, and volume data](https://docs.podman.io/en/latest/markdown/podman-system-prune.1.html), run this command ` $ podman system prune -f`


## 命令列介面環境


以下命令在 `docker` 目錄下執行。
```bash
$ cd docker
```
### 適用於 Linux/Mac

* 建立 Docker 映像，定制用戶開發環境參數，基礎源自 [texlive/texlive](https://hub.docker.com/r/texlive/texlive)。
```bash
$ sh unix/build.sh
```

<details>
<summary>腳本資訊</summary>

* [Advanced] 腳本中會偵測你電腦中已啟動的服務 **docker or podman**，若二者服務同時啟動，則以 podman 為主要服務。

</details>
</br>

* 啟動 latex-srv 並使用腳本在後台運行。
```bash
$ sh unix/start.sh
```

- 如果需要進入環境的 bash，可以通過 __attach__ 進入環境。如果想離開環境，請使用 `Ctrl`+`P` + `Ctrl`+`Q`。如果使用 `exit`，容器將被關閉。
```bash
$ sh unix/attach.sh
```

* 關閉 latex-srv 並關閉在後台運行的容器。
```bash
$ sh unix/stop.sh
```

### 適用於 Windows **未驗證** (cmd / PowerShell)

---
<div class="danger" style="
  padding:0.1em; 
  background-color: rgba(255, 99, 99, 0.2); /* Semi-transparent red background */
  color: #cd0000; /* Readable red text color */
  border-left: 0.5em solid #a50000; /* Dark red border on the left */
  border-radius: 10px; /* Rounded corners for all sides */
">
  <span>
    <p style="margin-top:1em; text-align:center; font-size:1.5em;">
      <b>警告</b>
    </p>
    <p style="text-align:center;">
      Windows 腳本尚未測試，請謹慎使用。
    </p>
  </span>
</div>

---
</br>

* 編譯 Docker 映像並定制用戶開發環境參數。基礎源自 [ubuntu](https://hub.docker.com/r/_/ubuntu)。可以用鼠標雙擊 build.bat 或使用 cmd / powershell 執行。
```powershell
> ./windows/build.bat
```

* 啟動 latex-srv，腳本將在後台運行。可以用鼠標雙擊 build.bat 或使用 cmd / powershell 執行。
```powershell
> ./windows/start.bat
```

* 如果需要進入環境的 bash，可以通過 attach 進入環境。如果想離開環境，請使用 `Ctrl`+`P` + `Ctrl`+`Q`。如果使用 `exit`，容器將被關閉。可以用鼠標雙擊 build.bat 或使用 cmd / powershell 執行。
```powershell
> ./windows/attach.bat
```

* 關閉 latex-srv 並關閉在後台運行的容器。可以用鼠標雙擊 build.bat 或使用 cmd / powershell 執行。
```powershell
> ./windows/stop.bat
```

## 如何構建代碼

在容器中清理構建目錄後重新編譯
```bash
$ rm -rf build/
$ sh built.sh
```

## 故障排除

- [How to make Visual Studio Code forward caught keystrokes?](https://superuser.com/questions/1784221/how-to-make-visual-studio-code-forward-caught-keystrokes)

> 在當前版本中，你可以：
> 
> 啟用 terminal.integrated.sendKeybindingsToShell - 這將把大多數按鍵發送到 shell，有些按鍵仍會被跳過。
> 
> 編輯 terminal.integrated.commandsToSkipShell - 你可以在這裡設置具體發送或不發送到 shell 的命令。這會被上面的選項覆蓋。例如，要禁用默認的 `Ctrl` + `B`，可以使用 -workbench.action.toggleSidebarVisibility：
> 
> ```
> "terminal.integrated.commandsToSkipShell": [
>   // 開頭的減號表示應該通過
>   "-workbench.action.toggleSidebarVisibility"
> ]
> ```
>
> `Ctrl` + `K` 的問題在於它被很多命令用作組合鍵。你可以禁用 terminal.integrated.allowChords 設置來完全取消組合鍵，這個設置也提到應該這樣做以使這些快捷鍵正常工作：
>> 注意，當設置為 true 且按鍵結果為組合鍵時，它將繞過 Terminal > Integrated: Commands To Skip Shell，設置為 false 尤其適用於希望 `Ctrl` + `K` 發送到 shell（而不是 VS Code）的情況
> 你可以在這裡閱讀更多相關信息。
>
> 取消綁定/重新綁定所有以你所需按鍵組合（例如 `Ctrl` + `K` -> `Ctrl` + `M`）開頭的組合鍵通常也能正常工作，我相信這是你可以嘗試的所有方法。
