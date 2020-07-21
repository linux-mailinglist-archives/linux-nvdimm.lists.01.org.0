Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5F227444
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jul 2020 02:58:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 89F2A1243CEAA;
	Mon, 20 Jul 2020 17:58:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8CC181243CEA5
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 17:58:50 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n2so14094597edr.5
        for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 17:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGtVdD2nEWSAU113PZhe2hv5MHlPJH23JUncqOBeJY0=;
        b=TicxJRsOh8783t529jSJMRkr8y4Zm4nuwkyuwFnsrgdDNsMVT2C7K9phpWYq4cjyWm
         CdDaairVbrtCrkrqGloXb3Kg+Hpawv0IiLCSS152OiROfES0HHSP2mMQzr/Ps8oiN3eY
         WNK2DCgi7LnWBoTFMQV1rD0fzkoJOX8CrVyh2A6N29vL10OD7biyVAHgrQr42iIrFovz
         Ggquj7bwc6RV3JqohG9ufGn2KxwFFK3DV47wsxuS/3VWMiqvDSR/Sw1DPwcNebavbySE
         k/WS+LvuJE4mzyYbkpSta8GQzN9y1whu3KyWLJRt31b6FaohPVSI7h6bHR4sYIl0E6tR
         nKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGtVdD2nEWSAU113PZhe2hv5MHlPJH23JUncqOBeJY0=;
        b=keAdRe+ic4q2JuPpgDwiFEw6VKuuKxlylaJ71uiZIxlziEloNl5xpv0yKl/iLzJojt
         lKdanbcqoh6F534QJPNEdfXg3skp2ddGKFiVYjr+ftMakdC9TI5FgT3KKAExHP6tIr5H
         nekoXPz9V8de1roIL0J7PXqpirPzsbCRLuvrPwylGLMdFrp32YQs8ggpXhk4tSC0LH0w
         9aXHVHvf3kvv1q0yvk0hpLSi1DHDNwDd6C6D24U+JQe/HSZZcJ+6bVblnNRIGfZbUnG6
         rlytO/Dk3qrtN67b3bVTGaI+RGLMjZ2CXtm6q5rxDNnjiYN0Mbkzx9JO4wmHjU0HXW/3
         aCSQ==
X-Gm-Message-State: AOAM5321FB5Je2UlSye3V84hOVAVa12xhdYXNHjKTgXzRoFkTA+SQmoE
	RBADOGh3uOLthzgd9Aa2XXBFw1Q1H5o+64m1pTsj+Q==
X-Google-Smtp-Source: ABdhPJxgQp44bjFNJWLzBYp6Is2/AsTzZZ4zfxGj9e6W5uADSL3R+H2d1wy4qAl88PCnEMIe9kqHQ9N3Qt//tTMNVOc=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr24567303edo.102.1595293128192;
 Mon, 20 Jul 2020 17:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
 <c825b5ee-ec03-7aa8-e380-6003f33fa113@infradead.org> <a6892924b53e8610753a13fa506099558f0efc6f.camel@intel.com>
In-Reply-To: <a6892924b53e8610753a13fa506099558f0efc6f.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 20 Jul 2020 17:58:37 -0700
Message-ID: <CAPcyv4hSs=yQmocOVa8S=6C_8=1DRa9Ba92PK4YsXRwndf3p=g@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] PM, libnvdimm: Add runtime firmware activation support
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: M727QLMZFOKH7PDHIYYKMHSLZEBQ7UXJ
X-Message-ID-Hash: M727QLMZFOKH7PDHIYYKMHSLZEBQ7UXJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Randy Dunlap <rdunlap@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/M727QLMZFOKH7PDHIYYKMHSLZEBQ7UXJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 20, 2020 at 5:14 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> On Mon, 2020-07-20 at 17:02 -0700, Randy Dunlap wrote:
> > Hi Dan,
> >
> > Documentation comments below:
>
> Dan, Randy,
>
> I'm happy to fix these up when applying.

Sounds good. Thanks Vishal.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
