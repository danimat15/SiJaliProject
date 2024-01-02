<div class="sidebar border border-right col-md-3 col-lg-2 p-0 bg-body-tertiary" style="height:100vh ;">
  <div class="offcanvas-md offcanvas-end bg-body-tertiary" tabindex="-1" id="sidebarMenu"
    aria-labelledby="sidebarMenuLabel">
    <div class="offcanvas-header">
      <h3 class="offcanvas-title" id="sidebarMenuLabel" style="align-items: center;">Si Jali KBLI</h3>
      <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-target="#sidebarMenu"
        aria-label="Close"></button>

    </div>
    <div class="offcanvas-body d-md-flex flex-column p-0 pt-lg-3 overflow-y-auto">
      <ul class="nav flex-column">

        <hr class="my-3">
        <div class="profile-section text-center mb-3">
          <img src="../assets/brand/logo.png" class="rounded-circle img-thumbnail" alt="Profile Picture" width="100"
            height="100">
          <h3>Admin</h3>
          <!-- Ganti dengan nama dari database -->
        </div>
        <hr class="my-3">
        <li class="nav-item">
          <a class="nav-link d-flex align-items-center gap-2" href="users.php">
            <svg class="bi">
              <use xlink:href="#people" />
            </svg>
            Daftar Users
          </a>
        </li>



        <!-- <hr class="my-3"> -->

        <ul class="nav flex-column mb-auto">

          <li class="nav-item">
            <a id="logoutLink" class="nav-link d-flex align-items-center gap-2" href="logout_proses.php">
              <svg class="bi">
                <use xlink:href="#door-closed" />
              </svg>
              Sign out
            </a>
          </li>


        </ul>
    </div>
  </div>
</div>