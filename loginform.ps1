function Show-LoginForm {
    param(
        [string]$Url
    )

    Add-Type -AssemblyName System.Windows.Forms

    # Create the form
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Login"
    $form.Size = New-Object System.Drawing.Size(400, 300)  # Increased height to 280
    $form.StartPosition = "CenterScreen"

    # URL Text
    $labelUrl = New-Object System.Windows.Forms.Label
    $labelUrl.Text = "URL:"
    $labelUrl.Location = New-Object System.Drawing.Point(10, 20)
    $labelUrl.Size = New-Object System.Drawing.Size(50, 20)

    $textUrl = New-Object System.Windows.Forms.Label
    $textUrl.Size = New-Object System.Drawing.Size(250, 20)
    $textUrl.Location = New-Object System.Drawing.Point(70, 20)

    # Set the URL value from the argument
    $textUrl.Text = $Url

    # Username Field
    $labelUsername = New-Object System.Windows.Forms.Label
    $labelUsername.Text = "Username:"
    $labelUsername.Location = New-Object System.Drawing.Point(10, 60)
    $labelUsername.Size = New-Object System.Drawing.Size(100, 20)

    $textUsername = New-Object System.Windows.Forms.TextBox
    $textUsername.Size = New-Object System.Drawing.Size(250, 20)
    $textUsername.Location = New-Object System.Drawing.Point(120, 60)

    # Password Field
    $labelPassword = New-Object System.Windows.Forms.Label
    $labelPassword.Text = "Password:"
    $labelPassword.Location = New-Object System.Drawing.Point(10, 100)
    $labelPassword.Size = New-Object System.Drawing.Size(100, 20)

    $textPassword = New-Object System.Windows.Forms.TextBox
    $textPassword.Size = New-Object System.Drawing.Size(250, 20)
    $textPassword.Location = New-Object System.Drawing.Point(120, 100)
    $textPassword.UseSystemPasswordChar = $true

    # Authentication Group
    $groupAuth = New-Object System.Windows.Forms.GroupBox
    $groupAuth.Text = "Authentication"
    $groupAuth.Size = New-Object System.Drawing.Size(360, 60)
    $groupAuth.Location = New-Object System.Drawing.Point(10, 140)

    $radioCyberArk = New-Object System.Windows.Forms.RadioButton
    $radioCyberArk.Text = "CyberArk"
    $radioCyberArk.Location = New-Object System.Drawing.Point(10, 20)
    $radioCyberArk.Checked = $true

    $radioRadius = New-Object System.Windows.Forms.RadioButton
    $radioRadius.Text = "Radius"
    $radioRadius.Location = New-Object System.Drawing.Point(120, 20)

    $radioLdap = New-Object System.Windows.Forms.RadioButton
    $radioLdap.Text = "LDAP"
    $radioLdap.Location = New-Object System.Drawing.Point(230, 20)

    $groupAuth.Controls.Add($radioCyberArk)
    $groupAuth.Controls.Add($radioRadius)
    $groupAuth.Controls.Add($radioLdap)

    # Submit Button
    $buttonSubmit = New-Object System.Windows.Forms.Button
    $buttonSubmit.Text = "Submit"
    $buttonSubmit.Size = New-Object System.Drawing.Size(100, 30)
    $buttonSubmit.Location = New-Object System.Drawing.Point(150, 210)  # Adjusted position

    # Event Handlers
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
    $form.Controls.Add($labelUrl)
    $form.Controls.Add($textUrl)
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
}

# Example usage:
$urlValue = "https://example.com"
$result = Show-LoginForm -Url $urlValue
$result
