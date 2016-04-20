
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});


Parse.Cloud.define("addFriendToFriendsRelation", function(request, response) {

    Parse.Cloud.useMasterKey();

    var friendRequestId = request.params.friendRequest;
    var query = new Parse.Query("kisses");

    //get the friend request object
    query.get(friendRequestId, {

        success: function(friendRequest) {

            //get the user the request was from
            var fromUser = friendRequest.get("from");
            //get the user the request is to
            var toUser = friendRequest.get("to");

            var relation = fromUser.relation("kissRelation");
            //add the user the request was to (the accepting user) to the fromUsers friends
            relation.add(toUser);

            //save the fromUser
            fromUser.save(null, {

                success: function() {

                    //saved the user, now edit the request status and save it
                    friendRequest.set("status", "accepted");
                    friendRequest.save(null, {

                        success: function() {

                            response.success("saved relation and updated friendRequest");
                        }, 

                        error: function(error) {

                            response.error(error);
                        }

                    });

                },

                error: function(error) {

                 response.error(error);

                }

            });

        },

        error: function(error) {

            response.error(error);

        }

    });

});



Parse.Cloud.define("addScoreToUser",function(request,response){
    
    Parse.Cloud.useMasterKey();
    
    var username = request.params.username;
    var value = request.params.value;
    var query = new Parse.Query(Parse.User);
    query.equalTo("username",username);
    
    return query.first({
        success:function(user){
            var initValue = user.get("total_score");
            var finalValue = initValue + value;
            user.set("total_score",finalValue);
            user.save();
            response.success("done");
            },
        error:function(error){
            response.error(error);
            }
    
        });
    

});

