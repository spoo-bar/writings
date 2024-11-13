---
title: "Adding a Custom Resource Provider for your ASP.NET application"
date: 2019-04-26T00:00:00+00:00
author: Spoorthi Satheesha
layout: post
permalink: /adding-a-custom-resource-provider-for-your-aspnet-application/
categories: Programming
tags: [c#]
excerpt: "Guide on how to add a Custom Language Resource Provider for your ASP.NET application"
seo_title: "Adding a Custom Resource Provider for your ASP.NET application"
seo_description: "Guide on how to add a Custom Language Resource Provider for your ASP.NET application"
---
New to ASP.NET resources? Check out the [**MSDN Documentation**](https://docs.microsoft.com/en-us/previous-versions/ms227427(v=vs.140)) before progressing with this post.

## ~ When & Why

Under usual circumstances, you will have _*.{lang}.resx_ named [**localization**](https://docs.microsoft.com/en-us/dotnet/standard/globalization-localization/) resource files under App_LocalResources and App_GlobalResources folder in your ASP.NET project root folder. These are compiled during the project build. However, you may come across a situation where you might need to update the resource files. There are three ways you can do this.

1. Edit your resx files and recompile the project and redeploy. 

    Releasing a whole update just to change a few words might not be worth it.

2. Have an endpoint within your project to update the resx file programmatically using the ResXResourceWriter class. 

    In this method, after the [**ResXResourceWriter**](https://docs.microsoft.com/en-us/dotnet/api/system.resources.resxresourcewriter?view=netframework-4.8) instance has been disposed, the [**AppPool**](https://www.developer.com/net/asp/article.php/2245511/IIS-and-ASPNET-The-Application-Pool.htm) is recycled.

3. Handle the localization string fetching yourself

     Under specific circumstances, you might not want your AppPool to get recycled. For example, you might have a [**SignalR**](https://dotnet.microsoft.com/apps/aspnet/real-time) listener setup on your server. In such circumstances, you can handle the resource reading yourself with the given implementation.

## ~ How

`System.Web` assembly provides an abstract [**ResourceProviderFactory**](https://docs.microsoft.com/en-us/dotnet/api/system.web.compilation.resourceproviderfactory?view=netframework-4.8) class which can be implemented easily. It requires you to create a global and a local resource provider. A global resource provider applies to the whole application while a local resource provider applies to a specific web page. In this sample, we are going to use the same resource provider for both.

```cs

// ResourceProvider.cs 

internal class ResourceProvider : IResourceProvider 
{    
    public IResourceReader ResourceReader => null;
    
    public object GetObject(string resourceKey, CultureInfo culture) 
    {
        if (culture.LCID == 1025) //1025 - Arabic
            return "مرحبا";
        else if (culture.LCID == 1036) //1036 - French
            return "Bonjour";
        else if (culture.LCID == 1081) //1081 - Hindi
            return "नमस्ते";
        return "Hello";
    }
}

```

```cs

// ResourceProviderFactory.cs 

[DesignTimeResourceProviderFactory(typeof(ResourceProviderFactory))]
public class ResourceProviderFactory : System.Web.Compilation.ResourceProviderFactory
{
    private ResourceProvider resourceProvider = new ResourceProvider();

    public override IResourceProvider CreateGlobalResourceProvider(string classKey)
    {
        return resourceProvider;
    }

    public override IResourceProvider CreateLocalResourceProvider(string virtualPath)
    {
        return resourceProvider;
    }
}

```

```xml

<!-- web.config  -->

<configuration>
  <location path="." allowOverride="true" inheritInChildApplications="false">
    <system.web>
      <globalization fileEncoding="utf-8" requestEncoding="utf-8" responseEncoding="utf-8" resourceProviderFactoryType="<%NAMESPACE%>.ResourceProviderFactory, <%NAMESPACE%>"/>
    </system.web>
  </location>
</configuration>

```

Register the custom resource provider in `web.config` in your project root. Implement your custom resource fetching logic in the `GetObject` method in `ResourceProvider` class.


### Sample Implementation Case 

You can have endpoints which update the localization data in the database, and you can in turn read the localization from the database. However, this can become a very slow process. Your entire webpage text should not be coming from the database for each request. You can cache the localizations server side and have an endpoint to clear this cache once the localizations are updated.
