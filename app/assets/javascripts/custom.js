document.addEventListener('DOMContentLoaded', function() {
  const sidebar = document.getElementById('sidebar');

  function isMobileDevice() {
    return (typeof window.orientation !== "undefined") || (navigator.userAgent.indexOf('IEMobile') !== -1);
  }

  function adjustSidebarWidth() {
    if (isMobileDevice()) {
      sidebar.classList.remove('w-1/5');
      sidebar.classList.add('w-3/5');
    } else if (window.innerWidth < 768) {
      sidebar.classList.remove('w-1/5');
      sidebar.classList.add('w-2/5');
    } else {
      sidebar.classList.remove('w-3/5', 'w-2/5');
      sidebar.classList.add('w-1/5');
    }
  }

  adjustSidebarWidth();

  window.addEventListener('resize', adjustSidebarWidth);
});