Wasabi.analysis = {
  // const_(location, op, value) {
  //   console.log(Wasabi)
  // } 

  start(location) {
    console.log("start")
    console.log(Wasabi)
    console.log(location)
  },

  call_pre(location, targetFunc, args, indirectTableIdx) {
    console.log("call_pre")
    console.log(Wasabi)
    console.log(location)
    console.log(targetFunc)
    console.log(args)
    console.log(indirectTableIdx)
  }, 
  
  begin(location, type) {
    console.log("begin")
    console.log(Wasabi)
    console.log(location)
    console.log(type)
  },

  end(location, type, beginLocation, ifLocation) {
    console.log("end")
    console.log(Wasabi)
    console.log(location)
    console.log(type)
    console.log(beginLocation)
    console.log(ifLocation)
  },

  call_post(location, values) {
    console.log("call_post")
    console.log(Wasabi)
    console.log(location)
    console.log(values)
  },
  
  return_(location, values) {
    console.log("return_")
    console.log(Wasabi)
    console.log(location)
    console.log(values)
  },
}
