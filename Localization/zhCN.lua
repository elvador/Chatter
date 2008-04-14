﻿local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Chatter", "zhCN")
if not L then return end

-- ./Chatter.lua
L["Standalone Config"] = "独立配置"
L["Open a standalone config window. You might consider installing |cffffff00BetterBlizzOptions|r to make the Blizzard UI options panel resizable."] = "打开一个独立的配置窗口。你也许希望使用|cffffff00BetterBlizzOptions|r插件使得暴雪的选项窗口可以调整大小。"
L["Configure"] = "配置"
L["Modules"] = "模块"
L["Settings"] = "设置"
L["Enable "] = "启用"
L["Enabled"] = "已启用"
L["Disabled"] = "已禁用"
L["Chatter Settings"] = "Chatter设置"
L["Welcome to Chatter! Type /chatter to configure."] = "欢迎使用Chatter！输入/chatter命令进行设置。"

-- ./Modules/AltNames.lua
L["Alt Linking"] = "小号链接"
L["Use PlayerNames coloring"] = "使用玩家名字颜色"
L["Use custom color"] = "使用自定义颜色"
L["Use channel color"] = "使用频道颜色"
L["Name color"] = "名字颜色"
L["Set the coloring mode for alt names"] = "设置小号名字的颜色模式"
L["Custom color"] = "自定义颜色"
L["Select the custom color to use for alt names"] = "为小号名字选择自定义颜色"
L["Who is %s's main?"] = "谁是%s的大号？"
L["Enables you to right-click a person's name in chat and set a note on them to be displayed in chat, such as their main character's name."] = "允许你右键点击一个人的名字，设置一个在聊天窗口中显示的备注，例如他们的大号的名字。"

-- ./Modules/AutoLogChat.lua
L["Chat Autolog"] = "聊天日志"
L["Automatically turns on chat logging."] = "自动启用游戏自带的聊天日志功能。"

-- ./Modules/Buttons.lua
L["Disable Buttons"] = "禁用按钮"
L["Show bottom when scrolled"] = "当滚动时显示底部"
L["Show bottom button when scrolled up"] = "当滚上去时显示底部按钮"
L["Hides the buttons attached to the chat frame"] = "隐藏附着在聊天框的按钮"

-- ./Modules/ChannelColors.lua
L["Keeps your channel colors by name rather than by number."] = "以名称为频道着色而不是以数字"
L["Other Channels"] = "其他频道"
L["Yell"] = "大喊"
L["Guild"] = "公会"
L["Officer"] = "官员"
L["Raid"] = "团队"
L["Party"] = "队伍"
L["Raid Warning"] = "团队警报"
L["Say"] = "说"
L["Battleground"] = "战场"
L["Whisper"] = "密语"
L["Select a color for this channel"] = "为该频道选择一个颜色"

-- ./Modules/ChannelNames.lua
L["Channel Names"] = "频道名称"
L["Raid Leader"] = "团队领袖"
L["LookingForGroup"] = "寻求组队"
L["Battleground Leader"] = "战场领袖"
L["Custom Channels"] = "自定义频道"
L["Replace this channel name with..."] = "将频道名字替换为……"
L["^To "] = "^发送给"
L["^(.-|h)悄悄地说："] = true
L["Enables you to replace channel names with your own names"] = "允许你用自己的名称替换掉默认的频道名称"

-- ./Modules/ChatFading.lua
L["Disable Fading"] = "禁用淡出"
L["Makes old text disappear rather than fade out"] = "使过期文字立刻消失而不是慢慢淡出"

-- ./Modules/ChatFont.lua
L["Chat Font"] = "聊天字体"
L["Font"] = "字体"
L["Font size"] = "字体大小"
L["Font Outline"] = "字体轮廓"
L["Font outlining"] = "字体轮廓"
L["Chat Frame "] = "聊天窗口"
L["Enables you to set a custom font and font size for your chat frames"] = "允许你为你的聊天窗口自定义字体以及字体大小"

-- ./Modules/ChatFrameBorders.lua
L["Borders/Background"] = "边框/背景"
L["Enable"] = "启用"
L["Enable borders on this frame"] = "为该窗体启用边框"
L["Combat Log Fix"] = "战斗日志修正"
L["Resize this border to fit the new combat log"] = "更改这个边框的大小以包容新的战斗日志"
L["Background texture"] = "背景贴图"
L["Border texture"] = "边框贴图"
L["Background color"] = "背景颜色"
L["Border color"] = "边框颜色"
L["Background Inset"] = "背景边距"
L["Tile Size"] = "背景块大小"
L["Edge Size"] = "边框块大小"
L["Gives you finer control over the chat frame's background and border colors"] = "使你能更好地控制聊天窗口背景及边框"

-- ./Modules/ChatLink.Lua
L["Chat Link"] = "聊天链接"
L["Lets you link items, enchants, spells, and quests in custom channels."] = "使你能够在自定义频道里链接物品，附魔，法术以及任务。"

-- ./Modules/ChatScroll.lua
L["Mousewheel Scroll"] = "鼠标滚轮滚动"
L["Scroll lines"] = "滚动行数"
L["How many lines to scroll per mouse wheel click"] = "每次滚轮滚动要卷动多少行"
L["Lets you use the mousewheel to page up and down chat."] = "允许你使用鼠标滚轮进行聊天记录翻页"

-- ./Modules/ChatTabs.lua
L["Chat Tabs"] = "聊天分栏"
L["Button Height"] = "按钮高度"
L["Button's height, and text offset from the frame"] = "按钮的高度，以及框体文字的偏移量"

-- ./Modules/ClickInvite.lua
L["Invite Links"] = "邀请链接"
L["Add Word"] = "添加关键词"
L["Add word to your invite trigger list"] = "添加关键词到你的邀请触发列表"
L["Remove Word"] = "移除关键词"
L["Remove a word from your invite trigger list"] = "从你的邀请触发列表移除关键词"
L["Remove this word from your trigger list?"] = "确定要移除这个关键词？"
L["invite"] = "组我"
L["inv"] = "组"
L["Lets you click the word 'invite' in chat to invite people to your party."] = "允许你点击聊天里面的“组”字邀请该玩家入队"

-- ./Modules/CopyChat.lua
L["Copy Chat"] = "聊天拷贝"
L["Lets you copy text out of your chat frames."] = "允许你把文字从聊天框拷贝出来"

-- ./Modules/EditBox.lua
L["Edit Box Polish"] = "输入框美化"
L["Top"] = "上"
L["Bottom"] = "下"
L["Free-floating"] = "自由浮动"
L["Free-floating, Locked"] = "自由浮动 - 已锁定"
L["Attach to..."] = "附着到……"
L["Attach edit box to..."] = "附着输入框到……"
L["Color border by channel"] = "按频道着色边框"
L["Sets the frame's border color to the color of your currently active channel"] = "根据你当前使用的频道来给框体边框上色"
L["Use Alt key for cursor movement"] = "使用Alt键移动光标"
L["Requires the Alt key to be held down to move the cursor in chat"] = "在文字间移动光标的时候需要按住Alt键"
L["Select the font to use for the edit box"] = "设置输入框里面的文字字体"
L["Lets you customize the position and look of the edit box"] = "允许你自定义输入框的外观和位置"

-- ./Modules/GroupSay.lua
L["Group Say (/gr)"] = "智能发言(/gr)"
L["Provides a /gr slash command to let you speak in your group (raid, party, or battleground) automatically."] = "允许你使用/gr命令自动依据你当前的队伍情况说在相应的队伍频道（团队，小队或者战场）里。"

-- ./Modules/Highlight.lua
L["Highlights"] = "高亮"
L["Use sound"] = "使用声音"
L["Play a soundfile when one of your keywords is said."] = "当有人说了你所设定的关键字时播放声音"
L["Show SCT message"] = "显示SCT信息"
L["Show highlights in your SCT mod"] = "在SCT插件里显示你的高亮信息"
L["Sound File"] = "声音文件"
L["Sound file to play"] = "要播放的声音文件"
L["Add word to your highlight list"] = "添加关键词到你的高亮列表里"
L["Remove a word from your highlight list"] = "从你的高亮列表里面移除一个关键词"
L["Remove this word from your highlights?"] = "你确信要移除这个关键词么？"
L["Custom Channel Sounds"] = "自定义频道声音"
L["Play a sound when a message is received in this channel"] = "当这个频道有新消息时播放一个声音"
L["%s said '%s' in %s"] = "%s说“%s”(于%s)"
L["Alerts you when someone says a keyword or speaks in a specified channel."] = "当某人说了一个关键字或者指定的频道有人说话时发出警报。"

-- ./Modules/Justify.lua
L["Text Justification"] = "文本对齐"
L["Enable text justification"] = "启用文本对齐"
L["Left"] = "左"
L["Right"] = "右"
L["Center"] = "中"
L["Lets you set the justification of text in your chat frames."] = "允许你设置你的聊天框文字如何对齐。"

-- ./Modules/LinkHover.lua
L["Link Hover"] = "链接悬停"
L["Makes link tooltips show when you hover them in chat."] = "当你将鼠标悬停在链接上时显示其提示信息框"

-- ./Modules/PlayerNames.lua
L["Player Names"] = "玩家名字"
L["Warlock"] = "术士"
L["Warrior"] = "战士"
L["Hunter"] = "猎人"
L["Mage"] = "法师"
L["Priest"] = "牧师"
L["Druid"] = "德鲁伊"
L["Paladin"] = "圣骑士"
L["Shaman"] = "萨满祭司"
L["Rogue"] = "潜行者"
L["Save Data"] = "保存数据"
L["Save data between sessions. Will increase memory usage"] = "在多次游戏间保存数据，将会增加内容使用量"
L["Save class data from guild between sessions."] = "在多次游戏间保存公会职业数据"
L["Group"] = "小队"
L["Save class data from groups between sessions."] = "在多次游戏间保存小队职业数据"
L["Target/Mouseover"] = "目标/鼠标悬停"
L["Save class data from target/mouseover between sessions."] = "在多次游戏间保存目标/鼠标悬停的职业数据"
L["Who"] = "查询"
L["Save class data from /who queries between sessions."] = "在多次游戏间保存/who查询的职业数据"
L["Reset Data"] = "重置数据"
L["Destroys all your saved class/level data"] = "清空所有你所保存的职业/等级数据"
L["Are you sure you want to delete all your saved class/level data?"] = "你确定要清空这些数据么？"
L["Left Bracket"] = "左括号"
L["Character to use for the left bracket"] = "设定左括号所使用的字符"
L["Right Bracket"] = "右括号"
L["Character to use for the right bracket"] = "设定右括号所使用的字符"
L["Use Tab Complete"] = "Tab键自动完成"
L["Use tab key to automatically complete character names."] = "使用Tab键自动完成玩家名字"
L["Level Options"] = "等级选项"
L["Include level"] = "包含等级"
L["Include the player's level"] = "包含玩家的等级"
L["Exclude Level 70s"] = "不包括70级"
L["Exclude level display for level 70s"] = "排除70级的级别显示"
L["Color level by difficulty"] = "按照等级难度着色等级"
L["Color Player Names By..."] = "用……着色玩家名字"
L["Select a method for coloring player names"] = "选择为玩家名字着色的方式"
L["Provides options to color player names, add player levels, and add tab completion of player names."] = "提供为玩家名字着色的选项，添加玩家的等级，以及Tab自动完成玩家名字输入。"

-- ./Modules/StickyChannels.lua
L["Sticky Channels"] = "固定频道"
L["Emote"] = "表情"
L["Raid warning"] = "团队警报"
L["Custom channels"] = "自定义频道"
L["Make %s sticky"] = "固定%s频道"
L["Makes channels you select sticky."] = "使你所选择的频道成为固定的输入频道。"

-- ./Modules/Telltarget.lua
L["Tell Target (/tt)"] = "密语目标(/tt)"
L["Enables the /tt command to send a tell to your target."] = "使用/tt命令发送一条密语到当前目标。"

-- ./Modules/Timestamps.lua
L["Timestamps"] = "时间戳"
L["HH:MM:SS AM (12-hour)"] = "时:分:秒 上午 (12小时制)"
L["HH:MM (12-hour)"] = "时:分 (12小时制)"
L["HH:MM:SS (24-hour)"] = "时:分:秒 (24小时制)"
L["HH:MM (24-hour)"] = "时:分 (24小时制)"
L["MM:SS"] = "分:秒"
L["Timestamp format"] = "时间戳格式"
L["Custom format (advanced)"] = "自定义格式（限高级用户）"
L["Enter a custom time format. See http://www.lua.org/pil/22.1.html for a list of valid formatting symbols."] = "自定义时间格式。可以参考 http://www.lua.org/pil/22.1.html 以查看都有哪些格式化符号可以使用。"
L["Timestamp color"] = "时间戳颜色"
L["Color timestamps the same as the channel they appear in."] = "依据时间戳所在的频道，用频道颜色为其着色。"
L["Adds timestamps to chat."] = "给聊天文字增加时间戳。"

-- ./Modules/TinyChat.lua
L["Tiny Chat"] = "迷你窗口"
L["Allows you to make the chat frames much smaller than usual."] = "允许你弄一个比平常小得多的聊天窗口。"

-- ./Modules/UrlCopy.lua
L["URL Copy"] = "网址复制"
L["Lets you copy URLs out of chat."] = "允许你将网址从聊天框中复制出来。"