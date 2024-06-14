Add-Type -AssemblyName System.Windows.Forms

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Login"
$form.Size = New-Object System.Drawing.Size(400, 350)
$form.StartPosition = "CenterScreen"

# URL Group
$groupUrl = New-Object System.Windows.Forms.GroupBox
$groupUrl.Text = "URL"
$groupUrl.Size = New-Object System.Drawing.Size(360, 80)
$groupUrl.Location = New-Object System.Drawing.Point(10, 10)

$radioProd = New-Object System.Windows.Forms.RadioButton
$radioProd.Text = "Prod"
$radioProd.Location = New-Object System.Drawing.Point(10, 20)
$radioProd.Checked = $true

$radioNonProd = New-Object System.Windows.Forms.RadioButton
$radioNonProd.Text = "Non-Prod"
$radioNonProd.Location = New-Object System.Drawing.Point(150, 20)

$textUrl = New-Object System.Windows.Forms.TextBox
$textUrl.Size = New-Object System.Drawing.Size(200, 20)
$textUrl.Location = New-Object System.Drawing.Point(10, 50)  # Moved to a new line with added space
$textUrl.ReadOnly = $true
$textUrl.Text = "https://prod.url"

$groupUrl.Controls.Add($radioProd)
$groupUrl.Controls.Add($radioNonProd)
$groupUrl.Controls.Add($textUrl)

# Username Field
$labelUsername = New-Object System.Windows.Forms.Label
$labelUsername.Text = "Username:"
$labelUsername.Location = New-Object System.Drawing.Point(10, 90)
$labelUsername.Size = New-Object System.Drawing.Size(100, 20)

$textUsername = New-Object System.Windows.Forms.TextBox
$textUsername.Size = New-Object System.Drawing.Size(250, 20)
$textUsername.Location = New-Object System.Drawing.Point(120, 90)

# Password Field
$labelPassword = New-Object System.Windows.Forms.Label
$labelPassword.Text = "Password:"
$labelPassword.Location = New-Object System.Drawing.Point(10, 130)
$labelPassword.Size = New-Object System.Drawing.Size(100, 20)

$textPassword = New-Object System.Windows.Forms.TextBox
$textPassword.Size = New-Object System.Drawing.Size(250, 20)
$textPassword.Location = New-Object System.Drawing.Point(120, 130)
$textPassword.UseSystemPasswordChar = $true

# Authentication Group
$groupAuth = New-Object System.Windows.Forms.GroupBox
$groupAuth.Text = "Authentication"
$groupAuth.Size = New-Object System.Drawing.Size(360, 60)
$groupAuth.Location = New-Object System.Drawing.Point(10, 170)

$radioCyberArk = New-Object System.Windows.Forms.RadioButton
$radioCyberArk.Text = "CyberArk"
$radioCyberArk.Location = New-Object System.Drawing.Point(10, 20)
$radioCyberArk.Checked = $true

$radioRadius = New-Object System.Windows.Forms.RadioButton
$radioRadius.Text = "Radius"
$radioRadius.Location = New-Object System.Drawing.Point(120, 20)

$radioLdap = New-Object System.Windows.Forms.RadioButton
$radioLdap.Text = "LDAP"
$radioLdap.Location = New-Object System.Drawing.Point(240, 20)

$groupAuth.Controls.Add($radioCyberArk)
$groupAuth.Controls.Add($radioRadius)
$groupAuth.Controls.Add($radioLdap)

# Submit Button
$buttonSubmit = New-Object System.Windows.Forms.Button
$buttonSubmit.Text = "Submit"
$buttonSubmit.Size = New-Object System.Drawing.Size(100, 30)
$buttonSubmit.Location = New-Object System.Drawing.Point(150, 240)

# Event Handlers
$radioProd.Add_CheckedChanged({
    if ($radioProd.Checked) {
        $textUrl.Text = "https://prod.url"
    }
})

$radioNonProd.Add_CheckedChanged({
    if ($radioNonProd.Checked) {
        $textUrl.Text = "https://non-prod.url"
    }
})

$buttonSubmit.Add_Click({
    $global:Result = @{
        URL = $textUrl.Text
        Username = $textUsername.Text
        Password = $textPassword.Text
        Authentication = if ($radioCyberArk.Checked) { "CyberArk" }
                         elseif ($radioRadius.Checked) { "Radius" }
                         else { "LDAP" }
    }
    $form.Close()
})

# Add controls to the form
$form.Controls.Add($groupUrl)
$form.Controls.Add($labelUsername)
$form.Controls.Add($textUsername)
$form.Controls.Add($labelPassword)
$form.Controls.Add($textPassword)
$form.Controls.Add($groupAuth)
$form.Controls.Add($buttonSubmit)

# Show the form
$form.ShowDialog()

# Output the result
$global:Result
