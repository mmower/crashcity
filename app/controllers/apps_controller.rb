class AppsController < ApplicationController
  def index
    @apps = App.find( :all )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apps }
    end
  end

  def show
    @app = App.find( params[:id] )

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @app }
    end
  end

  def destroy
    @app = App.find( params[:id] )
    @app.destroy

    respond_to do |format|
      format.html { redirect_to( admin_apps_url ) }
      format.xml  { head :ok }
    end
  end
  
end
