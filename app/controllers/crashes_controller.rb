class CrashesController < ApplicationController
  def index
    @crashes = if params[:bundle]
        if app = App.find_by_bundle( params[:bundle] )
          app.crashes
        else
          []
        end
      else
        Crash.find( :all )
      end
    
    respond_to do |format|
      format.html { render :action => params[:bundle] ? 'bundle_index' : 'index' }
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
