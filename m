Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DC930CA1B
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 19:42:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A97E8100EAB4E;
	Tue,  2 Feb 2021 10:42:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com; envelope-from=enbyamy@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DFFEA100F2252
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 10:42:15 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id x71so23822354oia.9
        for <linux-nvdimm@lists.01.org>; Tue, 02 Feb 2021 10:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGzfrsnXhgnNBXcQhxaXbM4GAEaugMss3IIAYpF95qk=;
        b=KL3fKa+7CX/VKuMHsaXqb1Kj/o/WTNYC1ZplA6ziaxDV4ag3iuqBjJaxr5+JgkAHsB
         tepUk47mcRKdWNP5rlWzlLA4kr5jYd+Z89LokH7fQ4SJUmOOBIi+43yx345F7CgB5mpm
         /Odz5mEq7ie34DkUkPBPTMMTMhqq9QCimELZ0ofKJIBAXKX9CHpRuV9YUgtZKMmYfZhX
         j2oFHgjRC3wdmkJopUkSvDHTJDP6YhdDISpc6kP02mR+uLdtwKc16mBpVe1KBevY/wDb
         f6mJaS1ioo7m/AwLJQyKmtRDTt/qRoyxIFkph3fW3sy0GKbPJ1t84xArtAl2ZjeMgRyf
         llkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGzfrsnXhgnNBXcQhxaXbM4GAEaugMss3IIAYpF95qk=;
        b=J6c6K2wIW0/R1zrZ5FOLih5wbgA7DTpasHIv4SNjBtZAvFuYSQlGTNiEgkweIKcXj0
         NnaI9JDdlydRU/lL9q/gmLxJbD/E48iyRwLGOddMHFXsWUkym521mre7rkv1KPOJYQB+
         XKjFJUt4XASJ4+tihyqTZlAn7HDiLTRyDJOmE18LXyb/oWMm/+JGLcc4MPRl/NkrGYDA
         BA2yD767uIXCjNLr8JcrwG8GN2L8xPfO9S8FosjwvK+MjtbC8taw1oP0Mau25V9wOS1m
         gcH44+xShgJWNGqzDH9znmv97ftrqJi2CWEexqPsFXz4zTGrDl2513d6PNsSkLEOLkHT
         JTig==
X-Gm-Message-State: AOAM532mdgEDvYNoDE5cG7LCxI9dlbCyNTrauKuQOK703xziSu2znc0L
	pZAhTH7kQMQI0cIF9i2r2dxdz+bq128RBW7UpBg=
X-Google-Smtp-Source: ABdhPJzBExcuHZCpDQGPbKvNqFaaijui4YpUFeAlLdQdLloNwkfYR8gbl9evSF4KyBBaFsTu/bpITB4lVZHkwVKGgBY=
X-Received: by 2002:a54:458f:: with SMTP id z15mr3878491oib.139.1612291334759;
 Tue, 02 Feb 2021 10:42:14 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT7ke9TR_H+et5_BUg93OYcDF0LD2ku+Cto59PhP6nz8qg@mail.gmail.com>
 <20201130133652.GK11250@quack2.suse.cz> <CAE1WUT5LbFiKTAmT8V-ERH-=aGUjhOw5ZMjPMmoNWTNTspzN9w@mail.gmail.com>
 <20201130150923.GM11250@quack2.suse.cz> <20201130163613.GE4327@casper.infradead.org>
In-Reply-To: <20201130163613.GE4327@casper.infradead.org>
From: Amy Parker <enbyamy@gmail.com>
Date: Tue, 2 Feb 2021 10:42:03 -0800
Message-ID: <CAE1WUT7mFw2_ndhW=P_Q8BRDb1rDOVixhp7sveqK=Ci6yi35fA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] fs: dax.c: move fs hole signifier from
 DAX_ZERO_PAGE to XA_ZERO_ENTRY
To: Matthew Wilcox <willy@infradead.org>
Message-ID-Hash: HWKWEUOPOZALBWVE2VJDWIZ5FG254JXT
X-Message-ID-Hash: HWKWEUOPOZALBWVE2VJDWIZ5FG254JXT
X-MailFrom: enbyamy@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HWKWEUOPOZALBWVE2VJDWIZ5FG254JXT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Apologize for taking a long time - this got swamped in a sea of other
kernel bits.

There doesn't seem to be much of a point now to switch to the XArray
zero entry for what is currently DAX_ZERO_ENTRY. However, if you want
to explore it further, a potential thought could be adapting the bits
around the XArray 257 entry. There's a large swath of available bits
that we could use between bit 3 and bit 9. If Matthew really wants to
use the XA zero entry for it, perhaps we could shift the other DAX
bits to those?

Best regards,
Amy Parker
(she/her/hers)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
