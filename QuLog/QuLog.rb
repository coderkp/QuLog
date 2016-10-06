require 'rubygems'
require 'csv'
$id= ""
$pw= ""
def encrypt(site,idd, pwd) 
           
CSV.open('trail.csv','a+') do |csv|
    csv<<[site,idd, pwd]
            end
        
        end
def decrypt(site)
    
        CSV.foreach("trail.csv") do |row|
            if row[0]==site
                $id= row[1]
                $pw= row[2]
            end
        end
end
        

Shoes.app  {
    
    background purple..white
    title("QuLog", top:15, align: "center",font: "Trebuchet MS", stroke: blue)
    para("Login with a single click", top:65, align: "center", font: "Arial", stroke: black)
    @install= button("Install QuLog dependencies", top: 100, align: "center", left: 180)
    @install.click{
        Shoes.setup do
        gem 'watir'
        end
        }
    para("If you are a first time user enter all the required data here", top:130, align: "center")
    @data= button("Enter data", top: 155, align: "center", left: 230)
    @data.click{
        window do
            #f= File.open("C:\Users\kushp\Desktop\pass.txt", "w","a")
            
            flow{ 
            para("Enter email for FB")
            @femail= edit_line            
                }
            stack
            flow do    
            para("Enter pwd for FB")
            @fpwd= edit_line(:secret => true)
            end
                
            flow{ 
            para("Enter email for Gmail")
            @gemail= edit_line            
                }
            stack
            flow do    
            para("Enter pwd for Gmail")
            @gpwd= edit_line(:secret => true)
            end
            
            flow{ 
            para("Enter userid for ERP")
            @eemail= edit_line            
                }
            stack
            flow do    
            para("Enter pwd for ERP")
            @epwd= edit_line(:secret => true)
            end
            
            flow{ 
            para("Enter userid for CMS")
            @cemail= edit_line            
                }
            stack
            flow do    
            para("Enter pwd for CMS")
            @cpwd= edit_line(:secret => true)
            end
            
            flow{ 
            para("Enter userid for SWD")
            @semail= edit_line            
                }
            stack
            flow do    
            para("Enter pwd for SWD")
            @spwd= edit_line(:secret => true)
            end
            
            flow{ 
            para("Enter userid for IDBI")
            @iemail= edit_line            
                }
            stack
            flow do    
            para("Enter pwd for IDBI")
            @ipwd= edit_line(:secret => true)
            end
            
            stack
            @submit= button("Submit",top:410, align: "center", left: 200)
            @submit.click{
                
                encrypt("FB",@femail.text, @fpwd.text)
                encrypt("GMAIL",@gemail.text, @gpwd.text)
                encrypt("ERP",@eemail.text, @epwd.text)            
                encrypt("CMS",@cemail.text, @cpwd.text)
                encrypt("SWD",@semail.text, @spwd.text)
                encrypt("IDBI",@iemail.text, @ipwd.text)
                window close
                }
        end
        
        }
    require 'watir'
    @fb= button("Facebook ", top: 185, align: "left", left: 15)
    @gmail= button("  Gmail  ", top: 185, align: "right", right: 15)
    @erp= button("   ERP   ", top: 220, align: "left", left: 15)
    @cms= button("   CMS   ", top: 220, align: "right", right: 15)
    @swd= button("   SWD   ", top: 255, align: "left", left: 15)
    @idbi=button("   TRY   ", top: 255, ign: "right", right: 15)
    #User has selected Facebook
    @fb.click{
        browser = Watir::Browser.new
url= "https://www.facebook.com/"
browser.goto url
b= browser.text_field(:type,"email")
p= browser.text_field(:type,"password")
        decrypt("FB")
        b.set($id)
        p.set($pw)


browser.button(:type, "submit").click

        }
    #User has selected GMAIL
    @gmail.click{
        browser = Watir::Browser.new
url= "https://accounts.google.com/ServiceLogin?service=mail&passive=true&rm=false&continue=https://mail.google.com/mail/&ss=1&scc=1&ltmpl=default&ltmplcache=2&emr=1&osid=1#identifier"
browser.goto url
b= browser.text_field(:id,"Email")
        decrypt("GMAIL")
b.set($id)
browser.button(:type,"submit").click
browser.text_field(:id,"Passwd").wait_until_present
p= browser.text_field(:id,"Passwd")
        p.set($pw)
browser.button(:id, "signIn").click
        }
    @erp.click{
        browser = Watir::Browser.new
        decrypt("ERP")
url= "https://erp.bits-pilani.ac.in:4431/psp/hcsprod/?cmd=login&languageCd=ENG"
browser.goto url
    b= browser.text_field(:id,"userid")
        b.set($id)
    p= browser.text_field(:id,"pwd")
    p.set($pw)
    browser.button(:type, "submit").click

        }
    @cms.click{
        browser = Watir::Browser.new
        url= "http://cms.bits-hyderabad.ac.in/bits-cms/login/index.php"
        browser.goto url
        b= browser.text_field(:id,"username")
        p= browser.text_field(:id,"password")
        decrypt("CMS")
        b.set($id)
        p.set($pw)
        browser.button(:type, "submit").click
        
        }
    @swd.click{
        browser = Watir::Browser.new
        url= "http://swd.bits-hyderabad.ac.in/"
        browser.goto url
        b= browser.text_field(:name,"login")
        p= browser.text_field(:name,"password")
        decrypt("SWD")
        b.set($id)
        p.set($pw)
        browser.button(:type, "submit").click
        
        }
    
@idbi.click{
        browser = Watir::Browser.new
        url= "https://inet.idbibank.co.in/corp/BANKAWAY?Action.RetUser.Init.001=Y&AppSignonBankId=IBKL&AppType=corporate"
        browser.goto url
        browser.image(:src, "web/L001/images/Phishing_12.jpg").click
        b= browser.text_field(:type,"text").wait_until_present
        p= browser.text_field(:type,"password").wait_until_present
        decrypt("IDBI")
        b.set($id)
        p.set($pw)
        browser.button(:type, "submit").click
        
        }


    }