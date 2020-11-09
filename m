Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DAD2AC4A2
	for <lists+linux-nvdimm@lfdr.de>; Mon,  9 Nov 2020 20:08:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7B50E16593981;
	Mon,  9 Nov 2020 11:08:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 242731651134A
	for <linux-nvdimm@lists.01.org>; Mon,  9 Nov 2020 11:08:51 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v4so9966649edi.0
        for <linux-nvdimm@lists.01.org>; Mon, 09 Nov 2020 11:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mIImtdsmUf0fZZedpKCd0x0pHi+mHJ9Vo26AZUq+4s=;
        b=i2fbZf6wqvNjiuHEuDZbKUvybO21dxmxYr8eNGYXirdcvjKGpCsK+nkLWYqzYII0Vj
         YVbfq8O97yydi3Mds0BmqTST0dIz7034BtWu01ek536G35HQr4FUA/MqDZlY1WCbgNzq
         sQbBPKjvSD0t5UYRo0x7Zw2M40BZuWXKUrenk0hXj90dLixB2pvGW7I/yNtjMmAFtsdS
         ymNiWHAFTPp8TgOkuMgJviBvfd2EwtzXsWJ0Q0eGU4n/6fY39rdjjLp7/Q01vOHirrEf
         8hYdCQkMfk5DiUPKeu6cLjV0oFMpGu+d/s9XtjzVHd36UDXGdeVbtLf1WowqWMTLm8S0
         MgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mIImtdsmUf0fZZedpKCd0x0pHi+mHJ9Vo26AZUq+4s=;
        b=I2TSArS//Q+v3eZvAVSCH3WIToA0RtCoIIVzlGSTSAfzd0sF5FWV+HxoYijqq4oGot
         8iAc8GIOTKBnxCnZr768jwv0q9CMgTN4LnQA/6Ycfhzr7D5ScQ6+66vZSE2w3uficStk
         FBef7soQDze75xOCX8tS6UQ5g43UjhPh53BDYYqDHI4Jhz6fmL7N3+MJMl2+V7bzUyn2
         jy9hvs445yzJt5aS9Q+jZdyTqxKUnokebk9D5jrJ1bK2cYe4KSOSaicv7rW53OSYn8p7
         37Fn6eJ6TP3FKcm5bGByksGdjOcvaBVJZJdbMJUl9mY7NLhH6loctXbLmFKUb8NONNg6
         GeFw==
X-Gm-Message-State: AOAM530URXrVydxg0YpY5LH6W9/a6TKRnvDU+fkMKXhvgSvJZ6blatKG
	eIyP17HEAVQPeNNTdMqkSKIpN6HXlO97JIDdQ8jtEQ==
X-Google-Smtp-Source: ABdhPJyWJxf+WrWssyDouX2E1tt1zBcBhQTuORfIXLE53GWgJ2FrUWMVSMNnblBDwRs1IDbxDpyu4vnk4mxb3mofoOA=
X-Received: by 2002:a05:6402:b35:: with SMTP id bo21mr17560764edb.52.1604948930462;
 Mon, 09 Nov 2020 11:08:50 -0800 (PST)
MIME-Version: 1.0
References: <20201020052704.331557-1-aneesh.kumar@linux.ibm.com> <87v9efp11c.fsf@linux.ibm.com>
In-Reply-To: <87v9efp11c.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 9 Nov 2020 11:08:39 -0800
Message-ID: <CAPcyv4iwk6EmGpivgczFgWf+Q3HSyeVm00cDf3rjmD4PUgamyQ@mail.gmail.com>
Subject: Re: [PATCH] daxctl: phys_index value 0 is valid
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: 5RU5VMBJEDW6ONNHXDFSER37H4RDCD2V
X-Message-ID-Hash: 5RU5VMBJEDW6ONNHXDFSER37H4RDCD2V
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5RU5VMBJEDW6ONNHXDFSER37H4RDCD2V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Nov 8, 2020 at 9:11 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
>
> Hi All,
>
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
> > On power platforms we can find
> >  # cat /sys/devices/system/memory/memory0/phys_index
> > 00000000
> >
> > This results in
> >
> > libdaxctl: memblock_in_dev: dax1.0: memory0: Unable to determine phys_index: Success
> >
> > Avoid considering phys_index == 0 as error.
>
>
>  A gentle ping for this patch. Will appreciate a feedback on this

Looks good to me. Apologies for the delay.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
