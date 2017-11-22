require('UIButton,UIFont,UIColor,UILabel,UIScreen,UIImageView,CGSize,CGRect,UITableView,UITableViewCell,NSMutableArray')
var screenWidth = UIScreen.mainScreen().bounds().width;
var screenHeight = UIScreen.mainScreen().bounds().height;

defineClass('TestVC:UIViewController<UITableViewDelegate,UITableViewDataSource>',["dataArray"],{
            viewDidLoad:function(){
            self.super().viewDidLoad();
            self.setTitle("新类");
            self.view().setBackgroundColor(UIColor.whiteColor());
            var rect = {x:0 ,y:0,width:screenWidth,height:screenHeight};
            var tableView = UITableView.alloc().initWithFrame_style(rect,0);
            tableView.setBackgroundColor(UIColor.greenColor());
            tableView.setDelegate(self);
            tableView.setDataSource(self);
            self.view().addSubview(tableView);
            self.setDataArray(['1','2','3','4']);
            },
            tableView_numberOfRowsInSection:function(tableView,section){
            return self.dataArray().length;
            },
            numberOfSectionsInTableView:function(tableView){
            return 1;
            },
            tableView_heightForRowAtIndexPath:function(tableView,indexPath){
            return 100;
            },
            
            tableView_cellForRowAtIndexPath:function(tableView,indexPath){
            var cell = tableView.dequeueReusableCellWithIdentifier("cell")
            if(!cell)
            {
              cell = UITableViewCell.alloc().initWithStyle_reuseIdentifier(1,"cell");
            }
            var text = self.dataArray()[indexPath.row()];
            cell.textLabel().setText(text);
            return cell;
            },
            tableView_didSelectRowAtIndexPath:function(tableView,indexPath)
            {
            var alert = require('UIAlertView').alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("alert",self.dataArray()[indexPath.row()],self,"确定",null);
            alert.show();
            }
})


defineClass('DetailViewController', {
    viewDidLoad:function(){
            self.super().viewDidLoad();
            self.ORIGviewDidLoad();
            self.view().setBackgroundColor(UIColor.whiteColor());
        var gobtn = UIButton.alloc().initWithFrame({x:(screenWidth-100)/2,y:(screenHeight+200)/2,width:100,height:60});
        gobtn.setBackgroundColor(UIColor.redColor());
            gobtn.addTarget_action_forControlEvents(self,"go",1);
        self.view().addSubview(gobtn);
        },
            go:function(){
            var test = TestVC.alloc().init();
            self.navigationController().pushViewController_animated(test,1);
            }
})

