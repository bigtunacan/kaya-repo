angular.module("MainModule", [])
  .controller("MainController", function ($scope, $http)
  {
	  $scope.chats = [];  
    $scope.newChat = "";
	  $scope.errors = [];
	
    $scope.submitData = function ()
    {
	  //$scope.newChat = "submitting data..."	
		
	  /* scope attaches to View */	

    /* $http.post("http://requestb.in/qwrtysqw", null, config)*/
	    $scope.chats.push($scope.newChat) /*this gets moved to success */
	  
    /*clear text field*/
      $scope.newChat = null
	    $http({
		    method: "POST",
		    url: "http://floating-beyond-3787.herokuapp.com/angular",
		    /*url: "https://worker-aws-us-east-1.iron.io/2/projects/542c8609827e3f0005000123/tasks/webhook?code_name=botweb&oauth=LOo5Nc0x0e2GJ838_nbKoheXqM0",*/
		    data: {input: $scope.newChat}
	    })
      
	    .success(function (data)
        {
         // $scope.chats.push(data);
		    $scope.chats.push($scope.newChat)
		 // if successful then get the value from the cache? 
		  
        })
        .error(function (data)
        {
          $scope.errors.push(data);
        });
		
      };
/*    
  .directive('enterLinktext', function() {
     return {
        scope: {
           submit: "=", //here you pass your controller's submit function
           textField: $scope.newChat //here you pass the scope variable which is bound to the text field
        },
        link: function(scope, element, attr){
           element.on("click", function(event){
              //on click, find the image and hide it
              angular.element(document.getElementById("imageId")).hide();

              //copy the <a> text to the text field
              scope.textField = element.html();
              scope.$apply();

              //call the controller submit function (the one that posts the form)
              scope.submitData();

              event.preventDefault();
           });
        }
     }
  });
*/    
		
  });