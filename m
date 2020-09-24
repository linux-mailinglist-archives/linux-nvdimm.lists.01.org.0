Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE2227746A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 24 Sep 2020 16:56:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AEBEB149D9082;
	Thu, 24 Sep 2020 07:55:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com; envelope-from=colomar.6.4.3@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 96F12149D9081
	for <linux-nvdimm@lists.01.org>; Thu, 24 Sep 2020 07:55:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e2so3932685wme.1
        for <linux-nvdimm@lists.01.org>; Thu, 24 Sep 2020 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cxvl2MAleQcMTiG0WSrWtQ8ZVgZ+BIbKryf5RRhV2Ew=;
        b=UF9OPLc72qF28w6y+ivkNrmXc5fop6lS4sjwHWDd9rzAFwH/YxcaJyc57rdANGsIN4
         rYSEqsboWQ/6Rad3EEZAYH6sJkptJizRO8lNfWk6XYA0XKnfcTxYON3ug44BYQg9EMER
         pVgAFcgLfPn4DVLiJ3Hib3T01PXbwRe+Vojn0wE3Yok5pMEIejrXlJffXDd6qKuKAg44
         VtKof8h0scpGdPAcmiLAwTnzsODA8lRMiZPWSwQRsP90h1aLFuABF5VbrFI/sWnrFX0b
         uEmRRAQsmZaOnouVl0mGoQ3uar4fcGrE+qSzboc3C0J0BGGDyYXkJ66tiP5wIrQLNFZH
         wH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cxvl2MAleQcMTiG0WSrWtQ8ZVgZ+BIbKryf5RRhV2Ew=;
        b=nKeGshxgZ3v6sW0ItiTuZOzxIhcYegLc90jJqefNGpsDFLAg+csdymDfpRNpH85V/X
         ExYApzAj5ELh4HbQ7E8rGLrttHOzcVJmm8l5pGOFxkOx/pLvUI0NuZhz3TOXeoXT2r/A
         9T11mCcaVTARCmzDO+wo+CWYDOed5J+GNUsySzwCXMPWCTISCR1oP1RjuIuthChQNnux
         GW9I076o0x8OTmMxz2o9fxCUdizn7op4eppNVYJYDDepSv6eBA3qpDHwsBta+XRYKKXp
         oD4vM8567FJjOtKAY0mi+Dk+zyt99O401LICZq1yDE8AkfsmRJzU5BKnRhLffaLRLJ9m
         eBDw==
X-Gm-Message-State: AOAM532wA4W65+NrftXiXZVp5CiNCxX1RGD9nnmizUeS8CqHVGKJSIJk
	v3wPpRpNouOm7HP8AiHi/Ug=
X-Google-Smtp-Source: ABdhPJwA7ld5rBdiNBafXko+QQDLwn3uoHLR26xm9fJkwIdPYX0Ec6468qIEwFlntmVrZ1YEq/Neew==
X-Received: by 2002:a1c:4b17:: with SMTP id y23mr5136571wma.162.1600959354790;
        Thu, 24 Sep 2020 07:55:54 -0700 (PDT)
Received: from [192.168.1.143] ([170.253.60.68])
        by smtp.gmail.com with ESMTPSA id h76sm4156994wme.10.2020.09.24.07.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 07:55:54 -0700 (PDT)
To: rppt@kernel.org
References: <20200924133513.1589-1-rppt@kernel.org>
Subject: Re: [PATCH] man2: new page describing memfd_secret() system call
From: Alejandro Colomar <colomar.6.4.3@gmail.com>
Message-ID: <efb6d051-2104-af26-bfb0-995f4716feb2@gmail.com>
Date: Thu, 24 Sep 2020 16:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924133513.1589-1-rppt@kernel.org>
Content-Language: en-US
Message-ID-Hash: 4QYV5MLYYDRPPSIRVZW337MFQQ22TF6R
X-Message-ID-Hash: 4QYV5MLYYDRPPSIRVZW337MFQQ22TF6R
X-MailFrom: colomar.6.4.3@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: akpm@linux-foundation.org, arnd@arndb.de, bp@alien8.de, catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com, david@redhat.com, elena.reshetova@intel.com, hpa@zytor.com, idan.yaniv@ibm.com, jejb@linux.ibm.com, kirill@shutemov.name, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, mtk.manpages@gmail.com, palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org, rppt@linux.ibm.com, shuah@kernel.org, tglx@linutronix.de, tycho@tycho.ws, viro@zeniv.linux.org.uk, will@kernel.org, willy@infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4QYV5MLYYDRPPSIRVZW337MFQQ22TF6R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

* Mike Rapoport:
 > +.PP
 > +.IR Note :
 > +There is no glibc wrapper for this system call; see NOTES.

You added a reference to NOTES, but then in notes there is nothing about 
it.  I guess you wanted to add the following to NOTES (taken from 
membarrier.2):

.PP
Glibc does not provide a wrapper for this system call; call it using
.BR syscall (2).

Cheers,

Alex
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
