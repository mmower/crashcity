class CrashesController < ApplicationController
  def index
    @crashes = if params[:bundle]
        app = App.find_by_bundle( params[:bundle] )
        app.crashes
      else
        Crash.find( :all )
      end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @crashes }
    end
  end
  
  def show
    @crash = Crash.find( params[:id] )
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @crash }
    end
  end
  
  def destroy
    @crash = Crash.find( params[:id] )
    @crash.destroy
    
    respond_to do |format|
      format.html { redirect_to( admin_crashes_url ) }
      format.xml  { head :ok }
    end
  end
  
end
