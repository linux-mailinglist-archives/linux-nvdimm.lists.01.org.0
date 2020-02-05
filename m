Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EBE153964
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 21:04:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EC27010FC33F8;
	Wed,  5 Feb 2020 12:07:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4D93B10FC33F7
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 12:07:45 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id a142so2065962oii.7
        for <linux-nvdimm@lists.01.org>; Wed, 05 Feb 2020 12:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHlc/MOybwrYmV5jBLq6KwrM1cJCP0BAaqLu3hdRYuc=;
        b=CD6HliQrmafHLbiUOUhYHhc6l3iLUEysgW48YyyFOOD8C6Wxi0lp/7Fkp+R+asK3xk
         /qXa+OD82i60kPgsWqkWXbBKbr4fQ/Pwl8XdBlR44obHbF4MQxk+1FKKR4/jDN1K6KTb
         5ExHzmIi3HXWktt6Sd8Uz6t2FBl6gab63IWpT3a9n/DjW42kQtjoZd2pkyDw3QAPb1+Y
         LFFh/TnY9BegxpWqanIVrypuMPMJJ6skpgcV5WP5QdnKpQ+Jhn3SQ5P6UG3B+o9LH2KA
         C0ALnk456XTS2djO3mLjNT3h5p03cw1cNsXiIzIc1FK5V53smNHbujOnBGfGi1MZgnLq
         zv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHlc/MOybwrYmV5jBLq6KwrM1cJCP0BAaqLu3hdRYuc=;
        b=PamSgXX0zm4HTxn2pJ3x2JhH1hE7++tPzQmcd+CoHp3gakoT8D8CSGECW/5obP9p+8
         bnkahBf4ZnIjBeMdFAEIkX77TpZnfq6+ioUjiGZUkUC+d0qGYObYpO0LWPNZMrwNM4A6
         i7kAh5qs170DmZa1oFSAPPvAZFqsxcBG4bw7CiYDpFAQvNN7lTCg8aBoZo6pUve8xUMv
         LoWajte22PhkO61D7zEWO3JCpv5zOxr6tEwHHpA3wiqkHOCauohgbs1780UZsZ+NVgWa
         NxmzIU5ZoPX2w0k8x/k/2N/WU26tG/bLAr6xekBZBzh31IIoxt/icOseqe76mVckATb8
         cJpw==
X-Gm-Message-State: APjAAAUAr/Ko7xY+4bFZ+i+ukklyckkChxMIsXjTZUB26Q1C8R1xCKJE
	DevmQNgRvS/sypJRj60j17oAZ/WwX4TO95l3F0VuposK3MI=
X-Google-Smtp-Source: APXvYqwWRxpod8ALY+krWqGBU60hDYKBExALTNx6xf7T7zljU6TIGzc80yMoms9veopfLDB49emhTf9VZkKwNoFhLAg=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr4472982oij.0.1580933067002;
 Wed, 05 Feb 2020 12:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20200205123826.kdvtsm47iy2ihw6r@kili.mountain>
 <CAPcyv4j12vgjgEgY3xAr9bpV8dd+3E7Q5Q3OFo2AXmwnN45PBA@mail.gmail.com>
 <20200205181040.GC24804@kadam> <CAPcyv4itFypOmv38Oo=DRWk_1Y3PFhPpYPDzxShmZVY9ZsTNLA@mail.gmail.com>
 <20200205190845.GD24804@kadam> <CAPcyv4jkTHeS2zTmYRoFi+evMemhmMkvPVcsBOQGXinGq6JyiQ@mail.gmail.com>
 <20200205192806.GE24804@kadam>
In-Reply-To: <20200205192806.GE24804@kadam>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 5 Feb 2020 12:04:15 -0800
Message-ID: <CAPcyv4gySPR0+sC1-xQsXirprX96Kyk764kUOuada+6djTXUjQ@mail.gmail.com>
Subject: Re: [bug report] libnvdimm, nvdimm: dimm driver and base libnvdimm
 device-driver infrastructure
To: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID-Hash: NUR64VYEO333LVGGCSUNLWPP63BPGD4K
X-Message-ID-Hash: NUR64VYEO333LVGGCSUNLWPP63BPGD4K
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NUR64VYEO333LVGGCSUNLWPP63BPGD4K/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 5, 2020 at 11:28 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Feb 05, 2020 at 11:16:22AM -0800, Dan Williams wrote:
> > Ugh, sorry I thought you were pointing out that there's too many
> > put_device() not the use after free. Yes, the use after free is a bug
> > that needs fixing.
>
> I am complaining about the device_puts...  If we call device_put()
> twice then it cause a problem in __nvdimm_create()
>
> drivers/nvdimm/dimm_devs.c
>    506          nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
>    507          nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
>    508          nd_device_register(dev);
>    509
>    510          return nvdimm;
>                        ^^^^^^
> If we call device_put() twice then we this pointer within 4 seconds.

"we this pointer"? We "what" this pointer. 4 seconds is relative to a
runtime test case?

...but yes, point taken this looks like an obvious leak in isolation.

>
>    511  }
>
> The fix is probably to make nd_device_register() return an error code so
> we can do:
>
>         ret = nd_device_register(dev);
>         if (ret) {
>                 device_put(&nvdimm->dev);
>                 return NULL;
>         }
>
>         return nvdimm;

Ok, so this is meant to be mitigated by the fact that all consumers of
nvdimm_create() perform a nvdimm_bus_check_dimm_count() to validate
that device_add() did not fail. The reason for this organization is to
allow nvdimm initialization to happen in parallel.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
