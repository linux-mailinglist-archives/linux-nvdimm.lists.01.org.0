Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410E42D42F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 May 2019 05:22:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6F9D52128D897;
	Tue, 28 May 2019 20:22:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9BA2A2128D6AB
 for <linux-nvdimm@lists.01.org>; Tue, 28 May 2019 20:22:36 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id i4so476349oih.4
 for <linux-nvdimm@lists.01.org>; Tue, 28 May 2019 20:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CmGsFYTByBfMv/I3+k36vNmiwVr/vGYKgWHgFC1df48=;
 b=CMhJCeRr+cZvwNip6QXNpdTl5pgx+OWYdppRfEzorY3VGAhDlCSdu+7XvkfsaXrxyZ
 ynvhlVopChe4o7CIx0DDi5TPzIV9Sl2+TawZOFPoww6tYkDZOqPAq+IP9JoVXXudf33I
 uZoZotAPOZ/bY8ASDUpzDUxzDPa/5QDj585E3EgirxsYVg5/vGTwjEyLqqH637AYDiyO
 PPGMQbhxi/MVBApovpX2gt/kqz3S6oCpySXUhaup6zrSqSJSKf4xP6mh3IL0no4+0HC2
 sc6hqQKzhSkbliiA+OtprQgfCXTC289xi100kHfxbW29FRKJe4YyaLrSdfc9W+dJKm5X
 BZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CmGsFYTByBfMv/I3+k36vNmiwVr/vGYKgWHgFC1df48=;
 b=gmNzUn7TRp4d6gDYdiPhk2O/H9l8mWXAsjidxFZRgAoUxb+fkkz8FXpUtH5igTchTD
 +RY1IgE6HsHtMDVpTgcaqHrCe/NDOXA6CXZmROkCcmJZx5xriZySQi+UZJ+AwFyDN10h
 sG2A798pJkyvNZolbCPfXHHcrvBYClIXMdK3Q+SypijtVDdhC+eL7pvbyoWKCKSVFIMw
 gE4FECDPpqZkZ1Tjjnj6cPeI8x3vu+ueknhl0rQ78jS8acLaR2EZQynJEz3nt4wMyn6p
 X9se3kqvnCkxtBuqbdd8k9JFXj9xhsZai//8NAxGOSgUlZx1+y7Rts+Od4RYhLZTKkbb
 C7oQ==
X-Gm-Message-State: APjAAAU2+5TaVkM9+ISJ+73b64wqwElbzHK9kRCGeZ/CHptc0aPunGht
 l8jGjO2kwfpMXYPuKZqMIcYUYNlBx2vGzh2Fev+UgQ==
X-Google-Smtp-Source: APXvYqyYEJqz/oEXkdLsBpcjaEBkc+lHjx+nyVq0ABEdQ08ECkYEYQC8B1zP8seKp+RWxPhEJm4+SdXKv2E9OG/yVhM=
X-Received: by 2002:aca:f512:: with SMTP id t18mr5016531oih.0.1559100155739;
 Tue, 28 May 2019 20:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190528222440.30392-1-vishal.l.verma@intel.com>
 <20190528222440.30392-6-vishal.l.verma@intel.com>
In-Reply-To: <20190528222440.30392-6-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 28 May 2019 20:22:24 -0700
Message-ID: <CAPcyv4hW-Gj5y+btKEsb1wOsKxd64hWY00NRDmeis3ZrkRo_pA@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 05/10] daxctl/list: add numa_node for device
 listings
To: Vishal Verma <vishal.l.verma@intel.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 28, 2019 at 3:24 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> The kernel provides a 'target_node' attribute for dax devices. When
> converting a dax device to the system-ram mode, the memory is hotplugged
> into this numa node. It would be helpful to print this in device
> listings so that it is easy for applications to detect the numa node to
> which the new memory belongs.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  util/json.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/util/json.c b/util/json.c
> index babdc8c..b7ce719 100644
> --- a/util/json.c
> +++ b/util/json.c
> @@ -271,6 +271,7 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
>  {
>         const char *devname = daxctl_dev_get_devname(dev);
>         struct json_object *jdev, *jobj;
> +       int node;
>
>         jdev = json_object_new_object();
>         if (!devname || !jdev)
> @@ -284,6 +285,13 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
>         if (jobj)
>                 json_object_object_add(jdev, "size", jobj);
>
> +       node = daxctl_dev_get_target_node(dev);
> +       if (node >= 0) {
> +               jobj = json_object_new_int(node);
> +               if (jobj)
> +                       json_object_object_add(jdev, "numa_node", jobj);

I think this should be named 'target_node' to not be confused with the
typical 'numa_node' attribute of a device that indicates closest cpu
node. This also collides with the 'numa_node' attribute that is
already emitted at the namespace level.

  {
    "dev":"namespace1.0",
    "mode":"devdax",
    "map":"dev",
    "size":134232408064,
    "uuid":"e6613922-80e9-49f9-ace8-961def867d32",
    "raw_uuid":"b79ce059-e33d-4a90-90ec-06d6786b3644",
    "daxregion":{
      "id":1,
      "size":134232408064,
      "align":2097152,
      "devices":[
        {
          "chardev":"dax1.0",
          "size":134232408064
        }
      ]
    },
    "align":2097152,
    "numa_node":0
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
