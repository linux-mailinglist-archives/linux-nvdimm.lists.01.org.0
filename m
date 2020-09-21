Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B5E2719AD
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 05:50:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A509014C64997;
	Sun, 20 Sep 2020 20:50:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1041; helo=mail-pj1-x1041.google.com; envelope-from=rhgadsdon@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 43A1B14C64996
	for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 20:50:17 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jw11so6445311pjb.0
        for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 20:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=y9gUatZD9QuyqAlm05aGA5o/i3RPKk46CeyCbsRfLsg=;
        b=ku6LGz56JeKHjeFmpWEl07wzZy//X6hghxfPTUEs2dJ//VVW/KfW1ovvdU8tWcIBBg
         oY6Y12jkFgBgyeUWiJC0ycVjVFPeJtn9IwXdiRMUFqcnLEtyWp/FzcJT2u30Ni0q/Vcl
         qrQ4hjlGi+TBVTxnzdS2tkxg8g9X/P/MGkMaqLLj3uGtfB9hURWx4ZYSuIwKZ257Jrg0
         SWoTMUV4vv3OIglvI8/1JAxJ9wsmmHcxgy6C/5GrcFPaAa24V5N/HSbiYqH/9y6jNEO3
         C/tabc174d9sBGPwf6uqIuJ0KbMRwBcICpLaeY3h30PCW9WEF4ZYp4OddN6vpO9DJ1lp
         NHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=y9gUatZD9QuyqAlm05aGA5o/i3RPKk46CeyCbsRfLsg=;
        b=jHDjraOI12/Te1yid8T6sBZzs71WSYL2R/4ia8Q9N+/Nlf8HhK4pkFpQTrCBtMhtiJ
         /YSXIz9Jk0DzDwoLjmgvRyj+7/F/amHPzfYtlICv2dO47h5r50yaEmDUS95xCR39gnlu
         zAJA4KhQlF12xfju46bJfRIR+/JyIovSDwzwI4ybmwbBorC7vPuviX3Qk/ZjA41p43aa
         t++LrzWj0nuAsFHZrgsjm7uJyK7WirArIm9+xM6Ge5vac7cwzwk5r3Q153Qv6a+2RJFw
         w0n+GVJ07qopFYI2bblghdHpDHEXsxOXvF6s9mk9qZ2lr4jiQPyC9MYFywX2Vi4H1eVe
         HlHw==
X-Gm-Message-State: AOAM530Suv/SJzZMn4h6lY7tWosDF0P1WuOobfdd5YmuEiACP+hp33n+
	JWRrWcjGNa9oQEaP3GWa5S4=
X-Google-Smtp-Source: ABdhPJw2vIajcVfKCt3bhM061zRNdAkhPwk4vl26wbvV7XFnD1bwaY77tGt0/V5JmqyzzYFYta1g6Q==
X-Received: by 2002:a17:90a:e60d:: with SMTP id j13mr23401859pjy.61.1600660216667;
        Sun, 20 Sep 2020 20:50:16 -0700 (PDT)
Received: from [10.203.4.217] ([209.58.129.104])
        by smtp.googlemail.com with ESMTPSA id e14sm10075566pgu.47.2020.09.20.20.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 20:50:15 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_PROBLEM=3a_5=2e9=2e0-rc6_fails_to_compile_due_to_?=
 =?UTF-8?B?J3JlZGVmaW5pdGlvbiBvZiDigJhkYXhfc3VwcG9ydGVk4oCZJw==?=
To: Stuart Little <achirvasub@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 linux-nvdimm@lists.01.org
References: <20200921010359.GO3027113@arch-chirva.localdomain>
 <20200921022550.GE3027080@arch-chirva.localdomain>
From: Robert Gadsdon <rhgadsdon@gmail.com>
Message-ID: <6a352fb6-ae2d-606d-34a0-cfc8ac1c88af@gmail.com>
Date: Sun, 20 Sep 2020 20:50:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921022550.GE3027080@arch-chirva.localdomain>
Content-Language: en-GB
Message-ID-Hash: R7GGRHSGSK2GGE7PCEY5RQTNN2KX75N4
X-Message-ID-Hash: R7GGRHSGSK2GGE7PCEY5RQTNN2KX75N4
X-MailFrom: rhgadsdon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: kernel list <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R7GGRHSGSK2GGE7PCEY5RQTNN2KX75N4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit


On 9/20/20 7:25 PM, Stuart Little wrote:
> An update on this: I've done a bisect, with the following result.
>
> --- cut here ---
>
> e2ec5128254518cae320d5dc631b71b94160f663 is the first bad commit
> commit e2ec5128254518cae320d5dc631b71b94160f663
> Author: Jan Kara <jack@suse.cz>
> Date:   Sun Sep 20 08:54:42 2020 -0700
>
>      dm: Call proper helper to determine dax support
>      
>      DM was calling generic_fsdax_supported() to determine whether a device
>      referenced in the DM table supports DAX. However this is a helper for "leaf" device drivers so that
>      they don't have to duplicate common generic checks. High level code
>      should call dax_supported() helper which that calls into appropriate
>      helper for the particular device. This problem manifested itself as
>      kernel messages:
>      
>      dm-3: error: dax access failed (-95)
>      
>      when lvm2-testsuite run in cases where a DM device was stacked on top of
>      another DM device.
>      
>      Fixes: 7bf7eac8d648 ("dax: Arrange for dax_supported check to span multiple devices")
>      Cc: <stable@vger.kernel.org>
>      Tested-by: Adrian Huang <ahuang12@lenovo.com>
>      Signed-off-by: Jan Kara <jack@suse.cz>
>      Acked-by: Mike Snitzer <snitzer@redhat.com>
>      Reported-by: kernel test robot <lkp@intel.com>
>      Link: https://lore.kernel.org/r/160061715195.13131.5503173247632041975.stgit@dwillia2-desk3.amr.corp.intel.com
>      Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
>   drivers/dax/super.c   |  4 ++++
>   drivers/md/dm-table.c | 10 +++++++---
>   include/linux/dax.h   | 22 ++++++++++++++++++++--
>   3 files changed, 31 insertions(+), 5 deletions(-)
>
> --- end ---
>
Confirm that reverting this patch, 5.9-rc6 compiles OK ...

RG.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
