return function(nodemgr,addNode)
    local videoInputNode = table.shallow_copy(nodemgr.nodeClass)
    videoInputNode.title="Digital video input"
    videoInputNode.shortTitle="Digital video input"
    videoInputNode.id="digital-video-input"
    videoInputNode.about="Node that returns a digital video file inputted by the user."
    videoInputNode.outputs={nodemgr.ioElem.digital}
    videoInputNode.color={0.49019607843137253,0.8549019607843137,0.34509803921568627,0.2}
    function videoInputNode.configure(screenNode)
        local opendvi = iup.filedlg{
            dialogtype = "OPEN",
            title = "Open digital video",
            filter = "*.mp4",
            filterinfo = "Video files",
        }

        opendvi:popup(iup.CENTER, iup.CENTER) -- Show the dialog

        if opendvi.status == "0" then
            print("selected file: " .. opendvi.value)
        elseif opendvi.status == "-1" then
            print("operation canceled")
        else
            print("error opening file")
        end
        screenNode.contentFile = opendvi.value
    end
    addNode(videoInputNode)

    local audioInputNode = table.shallow_copy(nodemgr.nodeClass)
    audioInputNode.title="Digital audio input"
    audioInputNode.shortTitle="Digital audio input"
    audioInputNode.id="digital-audio-input"
    audioInputNode.about="Node that returns a digital audio file inputted by the user."
    audioInputNode.outputs={nodemgr.ioElem.digital}
    audioInputNode.color={0.843137253,0.137,0.803921568627,0.2}
    addNode(audioInputNode)

    local AVInputNode = table.shallow_copy(nodemgr.nodeClass)
    AVInputNode.title="Digital audio-video input"
    AVInputNode.shortTitle="Digital AV input"
    AVInputNode.id="digital-audiovideo-input"
    AVInputNode.about="Node that returns a digital video file (output 1), and its corresponding audio track (output 2), inputted by the user."
    AVInputNode.outputs={nodemgr.ioElem.digital,nodemgr.ioElem.digital}
    AVInputNode.color={1,0.34,0.07,0.2}
    addNode(AVInputNode)
end
