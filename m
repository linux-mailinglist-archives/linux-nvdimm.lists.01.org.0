Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8DF27EF2A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Sep 2020 18:28:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56A881557BB83;
	Wed, 30 Sep 2020 09:28:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42D2C1557BB81
	for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 09:28:54 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m5so2903601lfp.7
        for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+misetaEJ1mwAT301R0A9ZIkFxdOGA996KoWa9fftk=;
        b=Sh6cwwahX+/y+BSWSCbArvYObCc1HWuntrcLxuME+7ufy6lS8eVNK//JaRPTKxHkMW
         /vI8TjEolAzzydnudtc2FOmU3njVteq6rwfp7z26pcwIJ/RgtV+gmPoQq2+bX1bE0ivo
         27/jAYWu30gafN/4p4RpUq/aWe96VB6akyMRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+misetaEJ1mwAT301R0A9ZIkFxdOGA996KoWa9fftk=;
        b=DyLHnFlA8C75WdjVDmIS7atMRu2yz61IxGISLCOmOgPDoz7KNnBTTwYfIrJ19X4c+S
         ZKn+QlgRr5hua9uq18mL+mu/eSEhmlwbaQZ+gBZZMGE0RSu14SRsPinFL2GwR3YjOSrL
         wK/7kzS20QEEuuYTVxKUcjzEhTBd18vx/SElQYr5bEaAKFhxxAQv17c5sGizquP2wSHU
         FHhaYR9wIekNO80XiTppuDMFXeShgcx9SrXuQN7J8Czusq54WqjPC0rGDX87uddTTok3
         3w9eR3HoAoPRf9f3OcYrPAloHQfQHVCK4DjxcS3xvhS+f3FqskWi44GEUyQF8jMYJqNC
         4j/Q==
X-Gm-Message-State: AOAM532N9jwf0EuMyEJBH57lLaPhYCEgpeN8raU+QGo8rsawXuebAxgg
	ShR3CdAvf1kn3trmSrGAL938G1b5PaR2wA==
X-Google-Smtp-Source: ABdhPJyCKR2L/oJg/+jcbkmVvQUtavHsjOAuI7gP+61JmXulxpchv7mrXiYHuiHQah9H4ktNQAbxOA==
X-Received: by 2002:ac2:5f77:: with SMTP id c23mr1253501lfc.568.1601483331543;
        Wed, 30 Sep 2020 09:28:51 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id i17sm204029lja.45.2020.09.30.09.28.49
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 09:28:50 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id w11so2910980lfn.2
        for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 09:28:49 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr1237100lfg.344.1601483329141;
 Wed, 30 Sep 2020 09:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <160087928642.3520.17063139768910633998.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4iPuRWSv_do_h8stU0-SiWxtKkQWvzBEU+78fDE6VffmA@mail.gmail.com>
 <20200930050455.GA6810@zn.tnic> <CAPcyv4j=eyVMbcnrGDGaPe4AVXy5pJwa6EapH3ePh+JdF6zxnQ@mail.gmail.com>
 <20200930162403.GI6810@zn.tnic>
In-Reply-To: <20200930162403.GI6810@zn.tnic>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Sep 2020 09:28:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmtMDW2oUfGrXTKcESqEHx1vWCqO65o051UNL-cX9AAg@mail.gmail.com>
Message-ID: <CAHk-=wjmtMDW2oUfGrXTKcESqEHx1vWCqO65o051UNL-cX9AAg@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] Renovate memcpy_mcsafe with copy_mc_to_{user, kernel}
To: Borislav Petkov <bp@alien8.de>
Message-ID-Hash: SQAOQVJLLET2K2C7P4QXTEJHCAAIMHGI
X-Message-ID-Hash: SQAOQVJLLET2K2C7P4QXTEJHCAAIMHGI
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, stable <stable@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Mikulas Patocka <mpatocka@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 0day robot <lkp@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SQAOQVJLLET2K2C7P4QXTEJHCAAIMHGI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 30, 2020 at 9:24 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Ok, I'll try to queue them but pls respin soonish. That is, if Linus
> cuts -rc8 we have plenty of time but he didn't sound 100% on the -rc8
> thing.

Oh, it's pretty much 100%.

I can't imagine what would make me skip an rc8 at this point.
Everything looks good right now (but not rc7, we had a stupid bug),
but I'd rather wait a week than fins another silly bug the day after
release (like happened in rc7)..

We're talking literal "biblical burning bushes telling me to do a
release" kind of events to skip rc8 by now.

           Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
