# The Slowest Lab

This app stores venues, shows, users, attendances of users to shows, and follows between users.  It's so slow!  Make it fast.  Write in the readme of your repo what changes you made and what effect they had.  Make migrations with your additional indexes, add eager loading, do joins, whatever is necessary.

To get started, create and migrate, then run `rake data:gen`.  This will take about 15 minutes, because it generates a lot of sample data, which we need because everything is fast with no data.

I suggest you start by optimizing the user page.  Go to /users/5, look at the logs created by that, and bring it down to below 100ms.  Right now the dashboard will take around 90 seconds, so save the dashboard for last.

You'll need to paginate some excessive queries also.  I suggest using kaminari.

# WHAT I DID
## user.rb aka USER MODEL
Added through relationships
```
has_many :shows, :through => :attendances
has_many :venues, :through => :shows
```

## users_controller.rb
Added Includes
```
def show
  @user = User.includes(:shows, :venues).find(params[:id])
  if signed_in?
    @following = current_user.outward_follows.where(
      :followed_id => @user.id).exists?
  end
end
```

#show.rb
```
has_many :users, :through => :attendances
```

## venues.rb
Added through relationship
```
has_many :attendances, :through => :shows
```

## venues_controller.rb
Added Includes
```
@venue = Venue.includes(:shows, :users).find(params[:id])
```

## Dashboard
* add indexes to attendances
* add venue index to shows