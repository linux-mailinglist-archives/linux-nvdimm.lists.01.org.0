Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE87B2DBA4D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 06:05:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2167E100ED497;
	Tue, 15 Dec 2020 21:05:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C4F55100ED48A
	for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 21:05:38 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id j16so1023390edr.0
        for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 21:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UDU9BeEeM/vqdn4I90oDVxBQIK7ye3sGeFFAhuXIm8I=;
        b=ktOabaBzztqwyMPz4s9rAB+FAY7IM9B6KITTdNo/KzubJ7t9QX3DqPvwe6ZOOjDaw1
         CMiRxGwq/TdOhzjN74tWAnG0uqwN6K8G/NnXY9eE4ayVA3kjxaof5ltsO7VHujItMGXC
         zodLfLbcB8syJ/oBO8Lm+wZ12610IuzGmQuJke1saTtbyqRwhG2RQ6NJLwdEXaCSJTK4
         VsUYfAXhXmSjuaLAjuFuuAHfXUsmj4hN8i/Nj+8y1WNGyhRfJDQa+aakjohac0d4IGzD
         lWHkH5TZRvpuOhq0VNZ8/tsAX2WXpkp6UvxgpvgCsiT5GKl91bLyVQo5s+L7xV5ZhHYF
         oqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UDU9BeEeM/vqdn4I90oDVxBQIK7ye3sGeFFAhuXIm8I=;
        b=Nb85FgRqLJ7vA7gQNLYpqnQgkJqnKtPU6V7blifRIx920d8gN0uB4u6eNE9HuzwrIn
         oNVYCtrsXmM/wzOgvM89T1T6NZIamhFfEcKNfw/YDkHWYxFvTdO7p2UNhC61cE7tmDgb
         Vosle17tzs7OkdakAQ1cFYILRjOLO7IGkqSq7df+5SHnQvN19BX9J5MChu5XqfdT3PCe
         ca64SoKrDHCKnGO8m3IBV8hP5YLoceOnhisYLZqYFBvKraleAeCvTYdlJaVuS4FpWSde
         jsfkzBhLBC2SsyC0dk4yjXzldTQ6eNiOPZVwy5hZ4sOspQEYDEVlDe9RXFuSr43kJeTW
         2i9g==
X-Gm-Message-State: AOAM532CGtGSy/VXb5Uc21s83oNunNAAttsoh2UPgRcB3AC7JqZB2cG0
	BL5UjDbaYnjzyarmggE6Pd8UTzsCf8gXBtVt4JDipA==
X-Google-Smtp-Source: ABdhPJzuR2HIBn3QZ0d8GMCERbWyNA3AdlkR6EzE+YDqDulJu/wBpKApu/wbn2vscWk1WvzJ5oBqCtPU/t3UPBngE64=
X-Received: by 2002:aa7:c2d8:: with SMTP id m24mr17561390edp.300.1608095137199;
 Tue, 15 Dec 2020 21:05:37 -0800 (PST)
MIME-Version: 1.0
References: <20201214103859.2409175-1-santosh@fossix.org> <20201214103859.2409175-2-santosh@fossix.org>
In-Reply-To: <20201214103859.2409175-2-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 15 Dec 2020 21:05:25 -0800
Message-ID: <CAPcyv4g-nAOPfBdkpeugXjaH=iBM5bg37wnSgszG7CT-sD069A@mail.gmail.com>
Subject: Re: [RFC v5 1/7] testing/nvdimm: Add test module for non-nfit platforms
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: B7BJIGKGQGAM6E6BVYW5J64REEKFYLOZ
X-Message-ID-Hash: B7BJIGKGQGAM6E6BVYW5J64REEKFYLOZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B7BJIGKGQGAM6E6BVYW5J64REEKFYLOZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 14, 2020 at 2:39 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> The current test module cannot be used for testing platforms (make check)
> that do not have support for NFIT. In order to get the ndctl tests working,
> we need a module which can emulate NVDIMM devices without relying on
> ACPI/NFIT.
>
> The aim of this proposed module is to implement a similar functionality to
> the existing module but without the ACPI dependencies.
>
> This RFC series is split into reviewable and compilable chunks.
>
> This patch adds a new driver and registers two nvdimm bus needed for ndctl
> make check.

I'd like to be able to test either nfit_test or nd_test by environment
variable from the same build. See the attached patch. Otherwise, if
the ndctl release process is not constantly testing nd_test it *will*
regress / bitrot.

So, "make check" should try nfit_test.ko, fallback to nd_test.ko, or
otherwise be forced to one or the other via an environment variable.
For example I'd like the release process on x86 to be:

make check
NVDIMM_TEST_MOD=nd_test make check

...where the first invocation assumes to test nfit_test.ko.

It needs some fixups to either prevent nfit_test and nd_test from
being loaded at the same time, or fixups to allow them to coexist.

This rework implies v5.11 is too aggressive a merge target.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
