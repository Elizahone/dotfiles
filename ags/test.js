

function Dashboard() {
  return Widget.Window({
    name: "Dashboard",
    margins: [60, 10, 35, 60],
    anchor: ["right", "bottom", "top"],
    child: Widget.Label("Hello world"),
  })
}


App.config({
  windows: [Dashboard()],
})
