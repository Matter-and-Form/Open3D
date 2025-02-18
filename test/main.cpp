#include <open3d/geometry/PointCloud.h>
#include <open3d/io/PointCloudIO.h>
#include <open3d/pipelines/registration/GeneralizedICP.h>

#include <iostream>

void TestPointCloud()
{
    open3d::geometry::PointCloud cloud1;

    // Write random points
    for (int i = 0; i < 20; ++i)
    {
        const double x = i;
        for (int j = 0; j < 20; ++j)
        {
            const double y = j;
            for (int k = 0; k < 20; ++k)
            {
                const double z = k;
                cloud1.points_.push_back({x, y, z});
            }
        }
    }

    open3d::geometry::PointCloud cloud2 = cloud1;

    Eigen::Matrix4d t = Eigen::Matrix4d::Identity();
    t(0, 3)           = 0.01;  // Translate x by 10
    t(1, 3)           = 0.05;  // Translate y by 5
    t(2, 3)           = 0.02;  // Translate z by 2
    cloud2.Transform(t);

    const auto result =
        open3d::pipelines::registration::RegistrationGeneralizedICP(cloud2, cloud1, 1.0);

    cloud2.Transform(result.transformation_);

    open3d::io::WritePointCloud("cloud1.ply", cloud1);
    open3d::io::WritePointCloud("cloud2.ply", cloud2);
}

int main()
{
    TestPointCloud();
    std::cout << "Open3D test finished." << std::endl;
    return 0;
}