# DNF
DNF是Fedora Project软件包管理器，它能够查询软件包信息，从存储库获取软件包，使用自动依赖关系解析安装和卸载软件包，并将整个系统更新到最新的可用软件包。DNF对正在更新，安装或删除的软件包执行自动依赖关系解析，从而能够自动确定，获取和安装所有可用的从属软件包。可以使用新的附加存储库或软件包源配置DNF ，还可以提供许多增强和扩展其功能的插件。DNF能够执行许多与RPM相同的任务能够; 另外，许多命令行选项是相似的。DNF可以在单台机器或其中的一组机器上进行简单而简单的包装管理。

> 使用GPG签名的软件包来保护软件包管理
> 
> DNF通过为GPG签名的软件包启用GPG（Gnu Privacy Guard;也称为GnuPG）签名验证来为所有软件包存储库（软件包源）或单个存储库启用安全软件包管理。启用签名验证后，DNF将拒绝安装任何未通过GPG签名的软件包，并使用该存储库的正确密钥签名。这意味着您可以相信您下载并安装在您的系统上的RPM软件包来自可信来源，如Fedora项目，并且在传输过程中不会被修改。有关启用DNF签名检查的详细信息，请参阅配置DNF和DNF存储库，或参阅检查包签名以获取有关使用和验证GPG签名RPM的信息 一般包。

DNF还使您能够轻松设置自己的RPM软件包存储库，以便下载和安装到其他机器上。

学习DNF是值得的投资，因为它通常是执行系统管理任务的最快方式，它提供的功能超出了PackageKit图形软件包管理工具提供的功能。

> DNF和超级用户权限
>
> 您必须拥有超级用户权限才能使用dnf命令在您的系统上安装，更新或删除软件包。本章中的所有示例都假定您已通过使用su或sudo命令获得超级用户权限。

## 检查和更新软件包
### 查询更新
检查更新的最快方法是使用`dnf upgrade`命令尝试安装任何可用的更新，如下所示:

    ~]# dnf upgrade
    Last metadata expiration check performed 1:24:32 ago on Thu May 14 23:23:51 2015.
    Dependencies resolved.
    Nothing to do.
    Complete!

请注意，`dnf upgrade`仅安装可以安装的更新。如果某个软件包因为依赖性问题而无法更新，则会跳过该软件包。

使用`dnf check-update`命令可以查看有哪些系统上安装的软件包有新版本可用，但是这并不意味着他们可以顺利安装。因此，此命令在脚本中非常有用，用于检查运行dnf升级后未安装的更新软件包。

例如：

    ~]# dnf check-update
    Using metadata from Mon Apr 20 16:34:10 2015 (2:42:10 hours old)

    python.x86_64                     2.7.9-6.fc22          updates
    python-cryptography.x86_64        0.8.2-1.fc22          updates
    python-libs.x86_64                2.7.9-6.fc22          updates

上述输出中列出了具有更新版本软件包。示例输出中的行告诉我们：

- python - 包的名字，
- x86_64 - 该软件包的CPU体系结构，
- 2.7.9 - 更新包的版本，
- 6.fc22 - 发布更新后的软件包，
- updates-testing - 更新软件包所在的存储库。

### 更新软件包
您可以选择一次更新单个软件包，多个软件包或所有软件包。如果您更新的软件包或软件包的任何依赖关系具有可用更新，则它们也会更新。

#### 更新单个软件包
要更新单个软件包，请使用root用户运行以下命令：

    dnf upgrade package_name

例如，更新python包，请输入：

    ~]# dnf upgrade python
    Using metadata from Mon Apr 20 16:38:16 2015 (2:42:14 hours old)
    Dependencies resolved.
    ==================================================================
    Package       Arch       Version       Repository       Size
    ==================================================================
    Upgrading:
    python        x86_64     2.7.9-6.fc22  updates           92 k
    python-libs   x86_64     2.7.9-6.fc22  updates          5.8 M

    Transaction Summary
    ==================================================================
    Upgrade  2 Packages

    Total download size: 5.9 M
    Is this ok [y/N]:

该输出包含：

1. `python.x86_64`- 你可以下载并安装的**python**软件包。
2. `python-libs.x86_64`- DNF已经发现了**python-libs-2.7.9-6.fc22.x86_64**包是**python**包所需的依赖。
3. DNF提供更新信息，然后提示您是否要执行更新; DNF默认通过交互式运行。如果您已经知道DNF计划执行的过程，那么您可以使用`-y`选项自动回答yes，以回答DNF可能提出的任何问题（在这种情况下，它将以非交互方式运行）。但是，您应该始终检查DNF计划对系统做出哪些更改，以便您可以轻松排除可能出现的任何问题。

如果安装过程发生错误，您可以使用`dnf history`命令查看DNF的历史记录，如使用[事务处理历史](#事务处理历史)。

> 使用DNF更新和安装内核
> 
> DNF总是安装一个新内核，这与RPM使用命令`rpm -i kernel`时安装新内核的意义相同。因此，当您使用dnf命令时，您不必担心安装和升级内核软件包的区别：无论您使用的是`dnf upgrade`还是`dnf install`命令，它都会做正确的事情。
> 
> 另一方面，使用RPM时，使用`rpm -i kernel`命令（它将安装一个新的内核）而不是`rpm -u kernel`（它取代当前内核）很重要。

#### 更新所有包及其依赖关系
要更新所有软件包及其依赖项，请输入不带任何参数的dnf upgrade：

    dnf upgrade

## 软件包和软件包组
### 搜索软件包
您可以使用以下命令搜索所有RPM软件包名称和摘要：

    dnf 
    search
    term…
    
添加`all`以匹配描述和网址。

    dnf 
    search all
    term…
    
此命令显示每个术语的匹配列表。例如，要列出所有匹配“meld”或“kompare”的包，请键入：

    ~]# dnf search meld kompare
    Loaded plugins: langpacks, presto, refresh-packagekit
    ============================ N/S Matched: meld ===============================
    meld.noarch : Visual diff and merge tool
    python-meld3.x86_64 : HTML/XML templating system for Python

    =========================== N/S Matched: kompare =============================
    komparator.x86_64 : Kompare and merge two folders

    Name and summary matches only, use "search all" for everything.

### 列出软件包
`dnf list`和相关命令提供有关软件包，软件包组和存储库的信息。

所有DNF的`list`命令允许您通过附加一个或多个glob表达式作为参数来过滤结果。Glob表达式是普通的字符串，它包含一个或多个通配符*（可扩展为多次匹配任何字符）和？（它扩展以匹配任何一个字符）。

> 使用glob表达式过滤结果
> 
> 在将它们作为参数传递给dnf命令时，要小心地将glob表达式转义，否则Bash shell会将这些表达式解释为路径名扩展，并可能将当前目录中与globs匹配的所有文件传递给DNF。要确保glob表达式按预期传递给DNF，可以：
> - 通过在前面加一个反斜杠字符来逃避通配符; 要么，
> - 双引号或单引号整个glob表达式。
> 
> 当使用glob表达式时，DNF只搜索包名。要搜索软件包的版本，请按如下方式包含破折号和部分版本号：
> 
>     ~]# dnf search kernel*-4*
>     Last metadata expiration check performed 2:46:09 ago on Thu May 14 23:23:51 2015.
>     Installed Packages
>     kernel.x86_64                        4.0.0-1.fc22                     @System
>     kernel.x86_64                        4.0.2-300.fc22                   @System
>     kernel-core.x86_64                   4.0.0-1.fc22                     @System
>     kernel-core.x86_64                   4.0.2-300.fc22                   @System
>     [output truncated]
请参阅使用glob表达式列出所有ABRT插件和插件，并使用带有转义通配符的单个glob表达式列出可用包，以获得这两种方法的示例用法。

#### dnf list *glob_expression* ...
列出与所有glob表达式匹配的已安装包和可用包的信息。

*示例1.使用glob表达式列出所有ABRT组件和插件*

包含各种ABRT插件和插件的软件包以“abrt-addon-”或“abrt-plugin-”开头。要列出这些软件包，请在shell提示符处输入以下内容：

    ~]# dnf list abrt-addon\* abrt-plugin\*
    Last metadata expiration check performed 0:14:36 ago on Mon May 25 23:38:13 2015.
    Installed Packages
    abrt-addon-ccpp.x86_64                  2.5.1-2.fc22               @System
    abrt-addon-coredump-helper.x86_64       2.5.1-2.fc22               @System
    abrt-addon-kerneloops.x86_64            2.5.1-2.fc22               @System
    abrt-addon-pstoreoops.x86_64            2.5.1-2.fc22               @System
    abrt-addon-python.x86_64                2.5.1-2.fc22               @System
    abrt-addon-python3.x86_64               2.5.1-2.fc22               @System
    abrt-addon-vmcore.x86_64                2.5.1-2.fc22               @System
    abrt-addon-xorg.x86_64                  2.5.1-2.fc22               @System
    abrt-plugin-bodhi.x86_64                2.5.1-2.fc22               @System
    Available Packages
    abrt-addon-upload-watch.x86_64          2.5.1-2.fc22               fedora

#### dnf list all
列出所有已安装和可用的包。

*例2.列出所有已安装和可用的软件包*

    ~]# dnf list all
    Last metadata expiration check performed 0:21:11 ago on Mon May 25 23:38:13 2015.
    Installed Packages
    NetworkManager.x86_64                   1:1.0.2-1.fc22             @System
    NetworkManager-libnm.x86_64             1:1.0.2-1.fc22             @System
    PackageKit.x86_64                       1.0.6-4.fc22               @System
    PackageKit-glib.x86_64                  1.0.6-4.fc22               @System
    aajohan-comfortaa-fonts.noarch          2.004-4.fc22               @System
    abrt.x86_64                             2.5.1-2.fc22               @System
    [output truncated]

#### dnf list installed
列出系统上安装的所有软件包。输出中最右边的列列出了从中检索包的存储库。

*示例3.使用双引号的glob表达式列出已安装的软件包*

要列出所有以“krb”开头并紧跟一个字符和连字符的已安装软件包，请键入：

    ~]# dnf list installed "krb?-*"
    Last metadata expiration check performed 0:34:45 ago on Mon May 25 23:38:13 2015.
    Installed Packages
    krb5-libs.x86_64                        1.13.1-3.fc22              @System
    krb5-workstation.x86_64                 1.13.1-3.fc22              @System

#### dnf list available
列出所有已启用存储库中的所有可用软件包。

*示例4.使用带有转义通配符的单个glob表达式列出可用包*

要列出名称中包含“gstreamer”和“plugin”的所有可用软件包，请运行以下命令：

    ~]# dnf list available gstreamer\*plugin\*
    Last metadata expiration check performed 0:42:15 ago on Mon May 25 23:38:13 2015.
    Available Packages
    gstreamer-plugin-crystalhd.i686              3.10.0-8.fc22          fedora
    gstreamer-plugin-crystalhd.x86_64            3.10.0-8.fc22          fedora
    gstreamer-plugins-bad-free.i686              0.10.23-24.fc22        fedora
    gstreamer-plugins-bad-free.x86_64            0.10.23-24.fc22        fedora
    gstreamer-plugins-bad-free-devel.i686        0.10.23-24.fc22        fedora
    gstreamer-plugins-bad-free-devel.x86_64      0.10.23-24.fc22        fedora
    [output truncated]

#### dnf group list
列出所有软件包组。

*例5.列出所有软件包组*

    ~]# dnf group list
    Loaded plugins: langpacks, presto, refresh-packagekit
    Setting up Group Process
    Installed Groups:
    Administration Tools
    Design Suite
    Dial-up Networking Support
    Fonts
    GNOME Desktop Environment
    [output truncated]

#### dnf repolist
列出为每个启用的存储库提供的存储库标识，名称和数量。

    ~]# dnf repolist
    Last metadata expiration check performed 0:48:29 ago on Mon May 25 23:38:13 2015.
    repo id                             repo name                           status
    *fedora                             Fedora 22 - x86_64                  44,762
    *updates                            Fedora 22 - x86_64 - Updates             0

#### dnf repository-packages *repo_id* list
列出指定存储库中的软件包。

*例7.从单个存储库中列出软件包*
dnf repository-packages repo_id list

    ~]# dnf repository-packages fedora list [option]
    Last metadata expiration check performed 1:38:25 ago on Wed May 20 22:16:16 2015.
    Installed Packages
    PackageKit.x86_64                        1.0.6-3.fc22                    @System
    PackageKit-glib.x86_64                   1.0.6-3.fc22                    @System
    aajohan-comfortaa-fonts.noarch           2.004-4.fc22                    @System
    [output truncated]

缺省操作是列出所有可用并已从指定存储库安装的软件包。添加`available`或`installed`选项仅列出可从指定存储库中获取或安装的那些软件包。

### 显示包装信息
要显示有关一个或多个软件包的信息，请按如下所示使用命令：

    dnf info package_name ...

例如，要显示有关abrt软件包的信息，请输入：

    ~]# dnf info abrt
    Last metadata expiration check: 1:09:44 ago on Tue May 31 06:51:51 2016.
    Installed Packages
    Name        : abrt
    Arch        : x86_64
    Epoch       : 0
    Version     : 2.8.1
    Release     : 1.fc24
    Size        : 2.2 M
    Repo        : @System
    From repo   : updates-testing
    Summary     : Automatic bug detection and reporting tool
    URL         : https://abrt.readthedocs.org/
    License     : GPLv2+
    Description : abrt is a tool to help users to detect defects in applications and
                : to create a bug report with all information needed by maintainer to fix it.
                : It uses plugin system to extend its functionality.

在`dnf info package_name`命令是类似于`rpm -q --info package_name`命令，但提供了作为附加信息的DNF的名称库的RPM包是从哪里安装的（查看From repo:对应的输出的内容）。在DNF信息命令只显示最新可用的软件包，如果有一个可用的新版本。在`dnf repoquery`命令可以显示所有已安装和可用的软件包。

要显示有关所有可用软件包的信息（已安装并可从存储库中获取），请按如下所示使用命令：
```
dnf repoquery package_name --info
```
例如，要显示有关abrt软件包的信息，请输入：

    ~]# dnf repoquery abrt  --info
    Last metadata expiration check: 1:01:44 ago on Tue May 31 06:51:51 2016.
    Name        : abrt
    Version     : 2.8.1
    Release     : 1.fc24
    Architecture: x86_64
    Size        : 2318452
    License     : GPLv2+
    Source RPM  : abrt-2.8.1-1.fc24.src.rpm
    Build Date  : 2016-05-25 08:54
    Packager    : Fedora Project
    URL         : https://abrt.readthedocs.org/
    Summary     : Automatic bug detection and reporting tool
    Description :
    abrt is a tool to help users to detect defects in applications and
    to create a bug report with all information needed by maintainer to fix it.
    It uses plugin system to extend its functionality.

有关更多选项，请参阅dnf repoquery用法语句：

    ~]$ dnf repoquery -h
    usage: dnf [options] COMMAND
    output truncated

### 安装软件包
DNF允许您安装单个软件包和多个软件包，以及您所选择的软件包组。

#### *安装单个软件包*
要安装单个软件包及其所有未安装的依赖项，请按以下格式输入命令：

dnf install package_name

您还可以通过追加名称来同时安装多个软件包：

    dnf install package_name  package_name ...

如果要在multilib系统（如AMD64或Intel64机器）上安装软件包，只要在启用的存储库中可用，就可以通过将.arch附加到软件包名称来指定软件包的体系结构。例如，要为`i586`安装**sqlite2**软件包，请输入：

    ~]# dnf install sqlite2.i586

您可以使用glob表达式快速安装多个名称相似的程序包：

    ~]# dnf install audacious-plugins-\*

除了包名称和glob表达式之外，您还可以提供文件名称给dnf install。如果您知道要安装的二进制文件的名称，但不知道它的软件包名称，则可以给dnf安装路径名称：

    ~]# dnf install /usr/sbin/named


然后，dnf搜索其软件包列表，找到提供/usr/sbin/named（如果有的话）的软件包，并提示您是否要安装它。

> 找到哪个包拥有一个文件
> 
> 如果您知道要安装包含`named`二进制文件的软件包，但不知道该文件在哪个目录`/usr/bin`或`/usr/sbin`目录中安装，请使用带有glob表达式的`dnf provides`命令：
> 
>     ~]# dnf provides "*bin/named"
>     Using metadata from Thu Apr 16 13:41:45 2015 (4:23:50 hours old)
>     bind-32:9.10.2-1.fc22.x86_64 : The Berkeley Internet Name Domain (BIND) DNS (Domain Name System) server
>     Repo        : @System
> dnf提供“*\*/file_name*”将查找所有包含*file_name*的包。

#### *安装软件包组*
包组与包类似：它本身并没有用，但是安装包会拉出一组用于共同目的的依赖包。包组具有名称和*groupid*(GID）。在`dnf group list -v`命令列出所有包组的名称，他们groupid在括号里面。groupid始终是最后一对括号中的术语，`kde-desktop-environment`如下例所示：

    ~]# dnf -v group list kde\*
    cachedir: /var/cache/dnf/x86_64/22
    Loaded plugins: builddep, config-manager, copr, playground, debuginfo-install, download, generate_completion_cache, kickstart, needs-restarting, noroot, protected_packages, Query, reposync, langpacks
    initialized Langpacks plugin
    DNF version: 0.6.5
    repo: using cache for: fedora
    not found deltainfo for: Fedora 22 - x86_64
    not found updateinfo for: Fedora 22 - x86_64
    repo: using cache for: updates-testing
    repo: using cache for: updates
    not found updateinfo for: Fedora 22 - x86_64 - Updates
    Using metadata from Thu Apr 16 13:41:45 2015 (4:37:51 hours old)
    Available environment groups:
    KDE Plasma Workspaces (kde-desktop-environment)

您可以通过将其全部组名（不带groupid部分）传递给组安装来安装软件包组：

    dnf group install group_name

必须引用多词的名称。

你也可以通过groupid安装：

    dnf 
    group install
    groupid
    
如果你用@符合（它告诉DNF你想执行组安装），你甚至可以将groupid或quoted name传递给install命令：

    dnf 
    install
    @group
    
例如，以下是安装KDE Plasma Workspaces组的另一种等效方式：

    ~]# dnf group install "KDE Plasma Workspaces"
    ~]# dnf group install kde-desktop-environment
    ~]# dnf install @kde-desktop-environment

### 删除软件包
与软件包安装类似，DNF允许您卸载（以RPM和DNF术语删除）单个软件包和软件包组。

#### *删除单独的包*
要卸载特定软件包以及依赖它的任何软件包，请使用root用户运行以下命令：

    dnf remove package_name…

当您安装多个软件包时，可以通过向命令添加更多软件包名称来一次删除多个软件包。例如，要删除**totem**，**rhythmbox**和**sound-juicer**，请在shell提示符处输入以下内容：

    ~]# dnf remove totem rhythmbox sound-juicer

与安装类似，remove可以接受这些参数：

- 包名称
- glob表达式
- 文件列表
- 包提供

> 当其他软件包依赖它时移除软件包
> 
> 如果不移除依赖它的软件包，DNF将无法移除软件包。这种类型的操作只能通过RPM执行，不建议，并且可能会使系统处于非运行状态，或导致应用程序异常中断并终止。有关更多信息，请参阅RPM章节中的卸载软件包。

#### *删除软件包组*
您可以使用与安装语法一致的语法来删除软件包组：

    dnf 
    group remove
    group

&nbsp;

    dnf 
    remove
    @group

以下是替代但等同的删除`KDE Plasma Workspaces`组的方法：

    ~]# dnf group remove "KDE Plasma Workspaces"
    ~]# dnf group remove kde-desktop-environment
    ~]# dnf remove @kde-desktop-environment

### 事务处理历史
在DNF历史命令允许用户查看有关DNF数据记录，他们发生时的日期和时间的时间表信息，包的数量的影响，交易成功还是被中止，如果RPM数据库事务之间变化。此外，该命令可用于撤销或重做某些事务。

#### *事务记录列表*
要显示所有事务的列表，请输入使用root输入以下命令，运行`dnf history`（不带其他参数）或输入以下命令：

    dnf
    history
    
    list
要仅显示给定范围内的事务，请使用以下形式的命令：

    dnf history list start_id..end_id

您也可以只列出关于特定包裹或包裹的事务。为此，请使用包名称或glob表达式的命令：

    dnf history list glob_expression…

例如，前五个事务的清单可能如下所示：

    ~]# dnf history list 1..4
    Using metadata from Thu Apr 16 13:41:45 2015 (5:47:31 hours old)
    ID    | Login user               | Date a | Action | Altere
    -------------------------------------------------------------------------------
        4 | root <root>              | 2015-04-16 18:35 | Erase          |    1
        3 | root <root>              | 2015-04-16 18:34 | Install        |    1
        2 | root <root>              | 2015-04-16 17:53 | Install        |    1
        1 | System <unset>           | 2015-04-16 14:14 | Install        |  668 E
在`dnf history list`命令产生每一行由下列列的表格输出：

- ID - 标识特定事务的整数值。
- Login user - 其登录会话用于启动事务的用户的名称。该信息通常以表格形式呈现，但有时会显示用于执行交易的命令。对于不是由用户发布的事务（例如自动系统更新），而是使用。Full Name <username>System <unset>
- Date and time - 交易发布的日期和时间。
- Action(s)- “操作”字段的“可能值”中所述的事务处理期间执行的操作列表。
- Altered - 受交易影响的软件包数量，其后可能还有其他信息。

表1.“操作”字段的可能值
行动  |	缩写  |  描述
-----|-------|-----
Downgrade | D | 至少有一个软件包已被降级为旧版本。
Erase | E | 至少有一个包已被删除。
Install |   I  |  至少安装了一个新软件包。
Obsoleting | O | 至少有一个包裹被标记为过期。
Reinstall   |   R   |  至少有一个包已被重新安装。
Update   |  U   |  至少有一个软件包已更新为新版本。

#### *恢复和重复事务*
除了查看交易历史记录外，dnf history命令还提供了恢复或重复选定交易的方法。要还原一个事务，请使用root用户在shell提示符处输入以下内容：

    DNF  
    history
    
    undo
    id

要重复某个特定事务，请以root用户运行以下命令：

    dnf 
    history
    
    redo
    id

这两个命令也接受`last`关键字来撤消或重复最新的事务。

请注意，`dnf history undo`命令和`dnf history redo`命令只会恢复或重复在事务处理期间执行的步骤，如果所需的软件包不可用，将会失败。例如，如果事务安装了新的程序包，则`dnf history undo`命令将卸载它并尝试将所有更新的程序包降级到其先前版本，但如果所需程序包不可用，该命令将失败。

## 配置DNF和DNF存储库
DNF和相关实用程序的配置文件位于`/etc/dnf/dnf.conf`。该文件包含一个强制性`[main]`部分内容，该部分允许您设置具有全局影响的DNF选项，还可能包含一个或多个`[repository]`，允许您设置特定于存储库的选项。但是，建议在`/etc/yum.repos.d/`目录中新的或现有`.repo`文件中定义单个存储库。您在`/etc/dnf/dnf.conf`文件中定义单个`[repository]`选项值会覆盖`[main]`选项中设置的值。

下面将向您介绍如何配置：
- 通过编辑`/etc/dnf/dnf.conf`配置文件的`[main]`部分内容来设置全局DNF选项;
- 通过编辑`/etc/yum.repos.d/`目录中`.repo `文件和`/etc/dnf/dnf.conf`文件的`[repository]`部分内容来为单个存储库设置选项;
- 通过修改`/etc/dnf/dnf.conf`和`/etc/yum.repos.d/`目录中的文件中的变量，以便正确处理动态版本和体系结构值;
- 在命令行上添加，启用和禁用DNF存储库; 和，
- 设置您自己的自定义DNF存储库。

### 设置[main]选项
`/etc/dnf/dnf.conf`配置文件只包含一个`[main]`，其中某些键值对会影响dnf的运行方式，其他键会影响DNF如何处理存储库。

您可以在`/etc/dnf/dnf.conf`文件中的`[main]`部分标题下添加许多其他选项。

一个简单的`/etc/dnf/dnf.conf`配置文件可能如下所示：

    [main]
    gpgcheck=1
    installonly_limit=3
    clean_requirements_on_remove=true

以下是在`[main]`部分中最常用的选项：

`debuglevel`=value
其中value是0和之间的整数10。设置较高的debuglevel值会导致dnf显示更详细的调试输出。debuglevel=0禁用调试输出，debuglevel=2是默认值。

exclude=package_name more_package_names
此选项允许您在安装和更新期间按关键字排除软件包。列出多个要排除的软件包可以通过引用空格分隔的软件包列表来完成。允许使用通配符（例如*和?）。

`gpgcheck`=value

其中value是下列之一：

`0` - 在所有存储库中的软件包上禁用GPG签名检查，包括安装本地软件包。

`1` - 对所有存储库中的所有软件包（包括安装本地软件包）启用GPG签名检查。`gpgcheck=1`是默认的，因此所有包的签名都被检查。

如果该选项在`/etc/dnf/dnf.conf`文件的`[main]`部分中设置，它将为所有存储库设置GPG检查规则。但是，您也可以为单个存储库设置`gpgcheck=value`; 您可以在一个存储库上启用GPG检查，同时在另一个存储库上禁用它。在单个存储库对应的`.repo`文件中设置`gpgcheck=value`将覆盖`/etc/dnf/dnf.conf`中的默认配置。

`installonlypkgs`=**space separated list of packages**

在这里，您可以提供一个空格分隔的包列表，dnf可以安装这些包，但永远不会更新。请参阅dnf.conf(5)手册页，了解默认只安装的包列表。

如果您将`installonlypkgs`指令添加到`/etc/dnf/dnf.conf`，您应该确保所有被列出来的包都是install-only的，包括在dnf.conf(5)的`installonlypkgs`部分中列出的所有包。特别是，内核包应该总是只在`installonlypkgs`中列出(因为它们是默认的)，并且`installonly_limit`应该总是设置为大于`2`的值，这样在默认情况下，备份内核总是可用的。

`installonly_limit`=value

其中，value是一个整数，表示可以为installonlypkgs指令中列出的任何单个程序包同时安装的最大版本数。

该installonlypkgs指令的默认值包括几个不同的内核软件包，因此请注意，更改此值installonly_limit也会影响任何单个内核软件包的最大安装版本数。`/etc/dnf/dnf.conf`中默认值是`installonly_limit=3`，并且不建议减小该值，特别不建议将其设置小于2。

`keepcache`=value

其中value是下列之一：

`0` - 成功安装后，请勿保留标题和包的缓存。这是默认设置。

`1` - 成功安装后保留缓存。

有关`[main]`可用选项的完整的列表，参考dnf.conf（5）手册页的[MAIN] OPTIONS一节。

### 设置[repository]选项
在`[repository]`部分，其中**repository**是唯一的存储库标识，例如`my_personal_repo`（不允许空格），允许您定义单独的DNF存储库。

以下是`[repository]`最基本示例：

    [repository]
    name=repository_name
    baseurl=repository_url


每个`[repository]`都必须包含以下指令：

`name`=**repository_name**

其中repository_name是一个描述存储库的人类可读字符串。

**parameter**=**repository_url**
其中**parameter**是下列中的一个：`baseurl`，`metalink`或`mirrorlist`;

其中**repository_url**是包含`repodata`存储库目录，metalink文件或镜像列表文件的目录的URL 。
- 如果存储库通过HTTP可用，请使用： http://path/to/repo
- 如果存储库通过FTP可用，请使用： ftp://path/to/repo
- 如果存储库对本机是本地的，请使用： file:///path/to/local/repo
- 如果某个特定的联机存储库需要基本的HTTP身份验证，则可以通过将其前置到URL中来指定您的用户名和密码`username:password@link`。例如，如果[http://www.example.com/repo/)](http://www.example.com/repo/)上的存储库需要用户名“user”和密码“password”，那么链接可以被指定为。baseurl[http://user:password@www.example.com/repo/](http://user:password@www.example.com/repo/)

通常这个URL是一个HTTP链接，例如：

    baseurl=http://path/to/repo/releases/$releasever/server/$basearch/os/

需要注意的是DNF总是扩展`$releasever`，`$arch`以及`$basearch`作为在URL中的变量。有关DNF变量的更多信息，请参阅[使用DNF变量](#使用DNF变量)。

要配置默认的存储库集，请按如下所示使用`enabled`选项：

`enabled`=value
其中value是下列之一：

`0` - 执行更新和安装时，不要将此存储库作为软件包源包含在内。

`1` - 将此存储库作为软件包源包含在内。

通过将选项`--set-enabled repo_name`或`--set-disabled repo_name`选项传递给dnf命令或通过`Add/Remove Software` PackageKit实用程序的窗口也可以执行打开和关闭存储库。

还有更多的`[repository]`配置选项。对于一个完整的列表，请参阅dnf.conf（5）手册页中的`[repository] OPTIONS`部分。

### 使用DNF变量
变量只能用于DNF配置文件的相应部分，即`/etc/dnf/dnf.conf`文件和`/etc/yum.repos.d/`目录中的所有`.repo`文件。存储库变量包括：

`$releasever`
指DNF从RPMDB中提供的信息派生出来的操作系统的发行版本。

`$arch`
指系统的CPU架构。有效值$arch包括：i586，i686和x86_64。

`$basearch`
指系统的基础架构。例如，i686和i586机器都具有基础架构i386，而AMD64和Intel64机器具有基础架构x86_64。

## 查看当前配置
要列出所有配置选项及其相应的值和存储库，请使用执行`dnf config-manager --dump`命令：

    ~]$ dnf config-manager --dump
    ============================= main ======================================
    [main]
    alwaysprompt = True
    assumeno = False
    assumeyes = False
    bandwidth = 0
    best = False
    bugtracker_url = https://bugzilla.redhat.com/enter_bug.cgi?product=Fedora&component=dnf
    cachedir = /var/cache/dnf/x86_64/22
    [output truncated]

## 添加，启用和禁用DNF存储库
设置[设置[repository]选项](#设置[repository])描述了您可以用来定义DNF资源库的各种选项。本节介绍如何使用`dnf config-manager`命令添加，启用和禁用存储库。

#### 添加DNF存储库
要定义新的存储库，您可以向`/etc/dnf/dnf.conf`添加[repository]，或到添加一个`.repo`文件到`/etc/yum.repos.d/`中。该目录中`.repo`扩展名的所有文件都被DNF读取，建议在这里定义您的存储库，而不是`/etc/dnf/dnf.conf`。

DNF存储库通常提供他们自己的`.repo`文件。要将这样的存储库添加到您的系统并启用它，请使用root用户运行以下命令：

    dnf config-manager --add-repo repository_url
    
其中**repository_url**是指向该`.repo`文件的链接。

**例子8.添加example.repo**

要添加位于[http://www.example.com/example.repo](http://www.example.com/example.repo)的存储库，请在shell提示符处输入以下内容：

    ~]# dnf config-manager --add-repo http://www.example.com/example.repo
    adding repo from: http://www.example.com/example.repo

#### 启用DNF存储库
要启用特定的存储库或存储库，请在shell提示符处键入以下内容：

    dnf config-manager 
    --set-enabled
    repository…

其中**repository**是唯一的存储库标识。要显示当前配置，请添加--dump选项。

#### 禁用DNF存储库
要禁用DNF存储库，请运行以下命令：

    dnf config-manager 
    --set-disabled
    repository…

其中**repository**是唯一的存储库标识。要显示当前配置，请添加--dump选项。

## 其他资源
安装文档

- dnf(8) - DNF命令参考手册页。

- dnf.conf(8) - DNF配置参考手册页。

在线文档
http://dnf.readthedocs.org/en/latest/index.html
DNF wiki包含更多文档。
