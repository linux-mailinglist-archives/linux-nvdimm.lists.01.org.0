Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8166C43D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 03:32:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65C99212C01E5;
	Wed, 17 Jul 2019 18:35:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 88B8B212C01DB
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 18:35:13 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o101so27206537ota.8
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 18:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1p856WhHfz+over8TZUWM7kXXLVxBosFAbw4pHLTbqo=;
 b=NZ/Cx7uwa+7cITmSB23Oj+SIJqKIYxe30wl5DspB0nodXEbGDncHk/PDtMyZlXJOQz
 KISE88EZD4od2gVEm1spztrXxj7sI3GEn0arjMBNrXeptJejRfQz+mDRSEnu+enUIOdZ
 dn2qXJ2uZXpT+4eLk0LVbXUODhq3N0xHJ34eQHU4cjHw2qZ/gnf/0LQyMXRiBJn/RYjB
 7CVfI2i+9p1KhTjg24UT2u+odKNVDOXRyhTaOUEV+UnzCdkky6pEUzBebSB0AkA3tMKl
 nm4Trz+WnndnarL9yx+ANaVtSYDZd7POSY0BdvlsLbVY7+vXMuiVGnQg/hcxEpjp50Bq
 nkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1p856WhHfz+over8TZUWM7kXXLVxBosFAbw4pHLTbqo=;
 b=HO+gO1A8z7LzDjifYqFOr0JWiBDDR3sJ3liqPB+DBCbIUqdQw+F4IEQuw0rVpl27ff
 eUQMl3/txIXtrYltBqJ5O+PcXYW4xjzFDbA0AFpR54WjFEucCzxa7PNT+oxVklqz7srS
 YMw37EU0pIeAVJYjaZDbCNhot5/cwXM4iV/cXdHWe+u4rjy/+y53PZG6okjsC3ZtJxWU
 kdTL5G+XS/nKC6qqftUmz3UlVkLeiMsl41X7R1gFTZgL7MnDZJO4OgjmxlUycqFFzezv
 AYjh6rqSoSTkmJ6NNsogAj0lc7vtCPP7kXaKe3ePcX1gpV5LnBjAL4ppQbb3juIiPAnU
 1Pfg==
X-Gm-Message-State: APjAAAUumOxKuHEG9XiZQbYM5xsdk2Bqp0XSwSicjDl1vIHygq7G0rpZ
 mcAAZ/2UVRT3X4bqU45LCYcAIlYAUDALBQrrUpdarg==
X-Google-Smtp-Source: APXvYqwBcG/PpagqMNmz02mHEwRj/zOU50fkTh5+O/EiDo1oxd/dK6nUDJ5OXDzQoWVir/Nx8vHxZWIRB+JbIJCl2C4=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr23484889otn.247.1563413564107; 
 Wed, 17 Jul 2019 18:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190717225400.9494-1-vishal.l.verma@intel.com>
 <20190717225400.9494-2-vishal.l.verma@intel.com>
In-Reply-To: <20190717225400.9494-2-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 17 Jul 2019 18:32:32 -0700
Message-ID: <CAPcyv4h333C36=G4F_yGwPi1mpvzH3rtwO15iffkWBr2yMNjVg@mail.gmail.com>
Subject: Re: [ndctl PATCH v6 01/13] libdaxctl: add interfaces to get ctx and
 check device state
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
> In preparation for libdaxctl and daxctl to grow operational modes for
> DAX devices, add the following supporting APIs:
>
>   daxctl_dev_get_ctx
>   daxctl_dev_is_enabled
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
