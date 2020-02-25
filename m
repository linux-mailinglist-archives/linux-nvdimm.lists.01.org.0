Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8C516ECA6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Feb 2020 18:39:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DE9F710FC3600;
	Tue, 25 Feb 2020 09:40:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 80B8E100780BF
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 09:40:36 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 59so257136otp.12
        for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 09:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OXHupn/eABYBBL7B4Fti1b+jxOPDWyjuii0bnF4epM=;
        b=AE8Q7vZmTYokhYjcCu+0V8M12z+lMXneKH2KNQyQURj0mJ5EYfGOBlZk9Cj3yEKaVR
         mm3V63hec1VXGCQ/iaLeWsOxWOxiNWDPGHTVrHpPBL5t8BR8Ajx3EPC3vmx8LRSTsWIM
         II5YOPb1K3dkHPTSFl0naBblR59myCgaMB4LDU0u2knaidrssXHl9JAVXDiwBbi5V7q/
         AmzAfQlPoZPHMwOf9VjEunUG2SEQi3fTgeIVBJqdOv/8mIfmfU73SSC5CBxH23Lx6Jsj
         pfHR2UE4Nv1pT65soOHOCBjngHOnHUiMYI/dWnItqyW+iIa84DL9QblBgOt8Y8maWC1q
         oMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OXHupn/eABYBBL7B4Fti1b+jxOPDWyjuii0bnF4epM=;
        b=psJkh8EqvpKu9NQXPVGfQanGiNZSNVHffSJxnZc0DI8ay9hwBs07tzB6t7JyF7ptGJ
         5eRExeosKYYPc4fssgqmoy+U8w1Z782XfEnDPRLR+MVzS38ZP7PdIGtcgIR5t+owOukl
         1ECD3i+f38/q7jGe8lvuaA2/HlwVVbh/inYqIfPd8ucAfONyzmu6elQfLdX4ZRNcdsr+
         CdroGW3j+dKz3qfBKcNX0KgLNCbjBHM/1J+Mc/ov1OcyiuJ3HpuOjHO8UxWT+j0GvXNL
         c57X0424gedsCa1klyCI7EEKoM0G9aY6IzctQGEbfvnsd/KfljTBSZhMKObAIW/wp3Ep
         vHRw==
X-Gm-Message-State: APjAAAWLV3ugghDSk5cFXHU9+uiYz00JxAUyF/LbPvnp/MvkH/3T7zM5
	sN81Dr6IVaZrSTEcc/fWP8zrZtLcCcCHetSWNvwssA==
X-Google-Smtp-Source: APXvYqwFDa7c/+xdMRI4xMWHsaudTDvmWW/yQIztlU6g8VlP3tvDXsNUwuJCiAlWSGRcL/rIhw1WqGwHAKcfPLxAWTE=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr42746705otl.71.1582652383462;
 Tue, 25 Feb 2020 09:39:43 -0800 (PST)
MIME-Version: 1.0
References: <20200225161927.hvftuq7kjn547fyj@kili.mountain>
In-Reply-To: <20200225161927.hvftuq7kjn547fyj@kili.mountain>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 25 Feb 2020 09:39:32 -0800
Message-ID: <CAPcyv4ht6kicLV_uk5Rt7a7iAxXrwuVoN2m6uVSw0h3qiE4AhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] acpi/nfit: improve bounds checking for 'func'
To: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID-Hash: XP5GC4UJ4JYCZ2RW5IWKFQRTLKMLAOGS
X-Message-ID-Hash: XP5GC4UJ4JYCZ2RW5IWKFQRTLKMLAOGS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XP5GC4UJ4JYCZ2RW5IWKFQRTLKMLAOGS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 25, 2020 at 8:20 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The 'func' variable can come from the user in the __nd_ioctl().  If it's
> too high then the (1 << func) shift in acpi_nfit_clear_to_send() is
> undefined.  In acpi_nfit_ctl() we pass 'func' to test_bit(func, &dsm_mask)
> which could result in an out of bounds access.
>
> To fix these issues, I introduced the NVDIMM_CMD_MAX (31) define and
> updated nfit_dsm_revid() to use that define as well instead of magic
> numbers.
>
> Fixes: 11189c1089da ("acpi/nfit: Fix command-supported detection")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I'll apply this to my fixes branch.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
