Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C31172EB50A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  5 Jan 2021 22:51:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF188100EBB9E;
	Tue,  5 Jan 2021 13:51:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5D481100EBB9D
	for <linux-nvdimm@lists.01.org>; Tue,  5 Jan 2021 13:51:30 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ce23so2470622ejb.8
        for <linux-nvdimm@lists.01.org>; Tue, 05 Jan 2021 13:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azp5R5sIE5akbR86AUgMTb7YlLtMSqlVoZhjPN7aS+Y=;
        b=cMncgAy6pqzxztVl5zeqBEgkiWWCLXEErKCEI6UQIaRXZcyG2cz9MQvSJrclBYIOxn
         2YPqPfCcc6iHayGMNjfpXQOmYSRuDcj/UGTDfYoaB71KOVEq+7uJ+qNGmbfq2RPd51lX
         aCz0Jm5SeMLydFqfwz50JnLiiSB6lnJQsmaexF+qcYDT/1ZAJlFQDeMFQlfTtIsiNVUG
         CvPGs26j1gRvSDfItMJ42fcL6bmPq+wLIYeSuzmXkilJ64+2VfPo0rt7DTRiPUUWo2Sw
         t9ck3g6Xbryu+fFBxzsgmWNQrsCJcBcPTPHYtKdyer81Oo3piddVUeL6GEzgnKSvUQ1P
         Fqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azp5R5sIE5akbR86AUgMTb7YlLtMSqlVoZhjPN7aS+Y=;
        b=BmHkLsvdXhCSy/z7xYGByrEgQ46v+5XI33ERLbVtVhQLHK+iOCAxaMtiunf+dIpQZv
         QQpDx8vkskfF96vGg5dXjOZYBJ8pdvyOmLsgjhQfJ45DEgKGgpMILXIpzGAKXUVVSlut
         h/7pzdyS2+tSr+kqoQlir1HawBBbUbbjsNygGSmP1iCyovCRAewUz6FmUEX+BXTUxNnw
         VLguN/PRFuLIdpKrUVs5/D4pht952KqR1q3p3bqbFgJOHfhLOyAqHHRuUEgkkzyWgl6U
         bsrPv5+guflh8H/Ca/RC7keqmaPqoQIf3IRu8aNaFSSKSNib+AxR7EJae74+d/Xy/ghH
         0tjw==
X-Gm-Message-State: AOAM530gQXmKqwCdbdyA3D8RDMKZNKYpi+JRooOWyclYskJ8g9u8Ewta
	Pv5BhsouYSygtzqO4EZwl3RlTzo0bWvPXcX0Ge6Y/g==
X-Google-Smtp-Source: ABdhPJx8QYz7csacame+QxQgcDO5RpmJDEOdfNCEf8pC9F7z4ASIVRi3CHLdkUBGbdfW8UJt1nJ5RoEtMuMwUCIDiwg=
X-Received: by 2002:a17:906:a29a:: with SMTP id i26mr914983ejz.45.1609883487897;
 Tue, 05 Jan 2021 13:51:27 -0800 (PST)
MIME-Version: 1.0
References: <160988059854.2071197.11821323682102566548.stgit@dwillia2-desk3.amr.corp.intel.com>
 <3c31c3328f569f15f03de9eb8d1b6a9ae4862893.camel@intel.com>
In-Reply-To: <3c31c3328f569f15f03de9eb8d1b6a9ae4862893.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 5 Jan 2021 13:51:16 -0800
Message-ID: <CAPcyv4jc3t8Vdes6Mu=HG=ro_Gg3nVck=_tWMPiOEPBm3M1qiw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NFIT: Fix flexible_array.cocci warnings
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Message-ID-Hash: IQVLTEPG6CTDZNVIIYUITIVJCDJ5ZAA5
X-Message-ID-Hash: IQVLTEPG6CTDZNVIIYUITIVJCDJ5ZAA5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "efremov@linux.com" <efremov@linux.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lkp <lkp@intel.com>, "julia.lawall@inria.fr" <julia.lawall@inria.fr>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IQVLTEPG6CTDZNVIIYUITIVJCDJ5ZAA5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 5, 2021 at 1:28 PM Verma, Vishal L <vishal.l.verma@intel.com> wrote:
>
> On Tue, 2021-01-05 at 13:03 -0800, Dan Williams wrote:
> > Julia and 0day report:
> >
> >     Zero-length and one-element arrays are deprecated, see
> >     Documentation/process/deprecated.rst
> >     Flexible-array members should be used instead.
> >
> > However, a straight conversion to flexible arrays yields:
> >
> >     drivers/acpi/nfit/core.c:2276:4: error: flexible array member in a struct with no named members
> >     drivers/acpi/nfit/core.c:2287:4: error: flexible array member in a struct with no named members
> >
> > Instead, just use plain arrays not embedded a flexible arrays.
>
> This reads a bit awkwardly, maybe:
>
>   "Just use plain arrays instead of embedded flexible arrays."

yeah, umm, I left that extra "a" in there as a test... you passed! :)

>
> Other than that, the patch looks looks good:
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

Thanks.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
