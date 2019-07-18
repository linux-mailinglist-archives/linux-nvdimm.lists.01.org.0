Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB556D756
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Jul 2019 01:41:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1857D212D2755;
	Thu, 18 Jul 2019 16:43:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 89CAC212B9A98
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 16:43:50 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id s184so22911544oie.9
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 16:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r/hONJtRZeMUuL4GdxGkX6st0mwVnT5+H+FD6ZdXHsk=;
 b=bFb3ehsaV3vD6EIcLUjAb2TlTRnjM/YQfmJ7xftKrsLzFKDqHbpfM2T+BMC+AJ9KI/
 Ef15O/ixKJA0cA+aYCEElNcSHvS3sPmHgy+ihUpF9WL7ZV6afbarRcTawsMnLFS93lbw
 pePKYpUNTjsQf4gYzbQjvswMJ+N5X4o8CqTbl3OH4Nhjx9LSaMUd8Qq9ZC3VUnP+0EAa
 22Eqh6d5l1H6VtqgGB1DcP/GcYzf2xzlpnpleqsJXXFwizMUuIkUjP5GsOmpQ/u6r3KV
 CSTTkQImElxQHm1s+0k5CsG4eUlrF1QbUHwRmrAAt67kZppMg1EMDPPIp7Z1voQpISyz
 ftag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r/hONJtRZeMUuL4GdxGkX6st0mwVnT5+H+FD6ZdXHsk=;
 b=ffWuxtCb6ocB7BGmfAr+5NTjJQdXioM1wEaLN7PYqW02AMgPasV/NcuLao8rO7OkUV
 PT/VVcgzq4Qy98kGalyqIhjGNxKuTf8aUvou2zXY35/u4MVs4R5EMSKGd9TNPCW9Bdl2
 b1LV5az+2tD+CZDNwA6TVwwqTVJEBbWeQdDmwptspTFSFB8VR1GsgHyR8n5+FdHSStKL
 zzRQ5sqYhzhjayRYLhXkytnVOMDd+Eu2g53SAPsKQm+iRvfhiJ39bRIVUwCajRQZLGs/
 oyNchx7qhUeDHMdVTT5MkyMzOIQk2AP0m89NR18FFez1mOUeaIOZPJwtMX0p3/npUb3/
 kAbg==
X-Gm-Message-State: APjAAAU5zf27kvi52QzADbEyQicvF6g2vS1rut5PDcVxrojKDDlFV5Pk
 cqxvvwd5LK6JK+QU6x0NcTTZAKIclnyBQsHfZMbrMw==
X-Google-Smtp-Source: APXvYqwm+p1SC+psVpq25qB++prNoeDWgT33JKZvToQEVjph+VxgwL1ZxG0Dd7UVlFiyKc3QVpT8vjN0pfif3kn7jmQ=
X-Received: by 2002:aca:d80a:: with SMTP id p10mr24677105oig.105.1563493282432; 
 Thu, 18 Jul 2019 16:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190717225400.9494-1-vishal.l.verma@intel.com>
 <20190717225400.9494-6-vishal.l.verma@intel.com>
In-Reply-To: <20190717225400.9494-6-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 18 Jul 2019 16:41:11 -0700
Message-ID: <CAPcyv4jeVMQP8QAtiQt81n1+jS7J49L8Ki_GDtT6rXFmaxMogQ@mail.gmail.com>
Subject: Re: [ndctl PATCH v6 05/13] daxctl/list: add target_node for device
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

On Wed, Jul 17, 2019 at 3:54 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> The kernel provides a 'target_node' attribute for dax devices. When
> converting a dax device to the system-ram mode, the memory is hotplugged
> into this numa node. It would be helpful to print this in device
> listings so that it is easy for applications to detect the node to
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
> index babdc8c..f521337 100644
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
> +                       json_object_object_add(jdev, "target_node", jobj);
> +       }
> +

We moved 'numa_node' to the UTIL_JSON_VERBOSE set on "ndctl list"
should do the same for target node?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
