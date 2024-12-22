return function(nodemgr,addNode)
    local digitalToNTSCNode = table.shallow_copy(nodemgr.nodeClass)
    digitalToNTSCNode.title="Digital video to NTSC"
    digitalToNTSCNode.shortTitle="Digital video to NTSC"
    digitalToNTSCNode.id="dvideo-to-ntsc"
    digitalToNTSCNode.about="Node that converts a digital video signal into an NTSC analog signal (Raw)."
    digitalToNTSCNode.inputs={nodemgr.ioElem.digital}
    digitalToNTSCNode.outputs={nodemgr.ioElem.avideo}
    digitalToNTSCNode.color={0.35,0.85,0.91,0.2}
    addNode(digitalToNTSCNode)

    local NTSCToDigitalNode = table.shallow_copy(nodemgr.nodeClass)
    NTSCToDigitalNode.title="NTSC to digital video"
    NTSCToDigitalNode.shortTitle="NTSC to digital video"
    NTSCToDigitalNode.id="ntsc-to-dvideo"
    NTSCToDigitalNode.about="Node that converts an NTSC analog signal (Raw) into a digital video signal."
    NTSCToDigitalNode.inputs={nodemgr.ioElem.avideo}
    NTSCToDigitalNode.outputs={nodemgr.ioElem.digital}
    NTSCToDigitalNode.color={0.98,0.78,0.20,0.2}
    addNode(NTSCToDigitalNode)
end
