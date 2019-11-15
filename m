Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF66FD3AC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 15 Nov 2019 05:30:54 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 48A7B100DC3CB;
	Thu, 14 Nov 2019 20:32:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9392D100EEBB6
	for <linux-nvdimm@lists.01.org>; Thu, 14 Nov 2019 20:32:16 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id s71so7473602oih.11
        for <linux-nvdimm@lists.01.org>; Thu, 14 Nov 2019 20:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRWArS8EY6M5DOjOjqwZ6+pvf8YoFwoc/oPe6h/50XU=;
        b=guB1CbXX81G22dmWZBHxcVVxa54wwF5isiRP8DfyGl6WLw5qsD8/1yYkL94xe1bvja
         YWrfIftutXLXDL0eJK6ZS/da065bfHQYvNr79ght47XY6Zo0Ik8kf5tpJXSMFAAFQnCw
         ubcAHiqDy1ycfTVOPB41eht7V6f8fV65ZKDZ0inrspQuNJKy3jkEwKSowxth/UevHA+Z
         fTEAoFQL0v3zpTHMc57OpaWN8U0odan50b9dK7PBSP1E9f0eElQWxG9JTLJNXx33+/fU
         uN/a1NVNCswzKJSR8+RQj5yu/EViETOWFER8emzdphHbCRqRIAw57SwazMYWno23m3Pf
         w2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRWArS8EY6M5DOjOjqwZ6+pvf8YoFwoc/oPe6h/50XU=;
        b=lSUNlsrqefgQvO5o+fBRKNahtFPZTF624nkFOSitWh8Tx7M+fpmqVWphv9vIThNZyc
         lao5e7kI3lZnYxwsu8lzEgYIPShS8PTagCteTUD4qRgCPuhpGfJF4Pwtt37PUACFVOVj
         BVE08WdhAphoPjr7g/QjZUKM3Zm05hbSG1IhvVg6DasTpd9Kn7zHOGZ+n7uCtoeWKKx9
         jjrCt1iyoUYpBZcc+yEPL1damoSsk9YPVOwK7f+8QfpTubrhrfePVoOnybsSpSAe8NLe
         dxrU+2P5U8W0QoWY0wLCZF/gCSBQQbwud6ziTpn3NfMFN5URLf3jgzUWaRbeDVFMeTaY
         si8A==
X-Gm-Message-State: APjAAAVg9a1sqMc4SwPwG2Y1RvGVzHAkxPcixLD5U/bfRmIfh4Hz4t0q
	iGuNvScWMFc6Lbf100r6seK5AmCPE8p0UIwAEZwTiQ==
X-Google-Smtp-Source: APXvYqxglauMMGlyWf/TClpfIHTmgAmcgrRFm8og4eYzgO7jYK3rFnEyN8B0fbbAiBI0hQLPzfZ1wmS7ammk00zCWVA=
X-Received: by 2002:aca:ead7:: with SMTP id i206mr6863559oih.0.1573792250134;
 Thu, 14 Nov 2019 20:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20191025044721.16617-1-alastair@au1.ibm.com> <20191025044721.16617-3-alastair@au1.ibm.com>
In-Reply-To: <20191025044721.16617-3-alastair@au1.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 14 Nov 2019 20:30:38 -0800
Message-ID: <CAPcyv4gb7xZpY+F9qupJbLznqHbyCOuOee8R6aLby72UkyjtZg@mail.gmail.com>
Subject: Re: [PATCH 02/10] nvdimm: remove prototypes for nonexistent functions
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Message-ID-Hash: 6X4PFG2QUQSRJUE52BIOY5RGPONWMAQV
X-Message-ID-Hash: 6X4PFG2QUQSRJUE52BIOY5RGPONWMAQV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: alastair@d-silva.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Anton Blanchard <anton@ozlabs.org>, David Gibson <david@gibson.dropbear.id.au>, Hari Bathini <hbathini@linux.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com
 >, Qian Cai <cai@lca.pw>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6X4PFG2QUQSRJUE52BIOY5RGPONWMAQV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 24, 2019 at 9:49 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> From: Alastair D'Silva <alastair@d-silva.org>
>
> These functions don't exist, so remove the prototypes for them.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Looks good, applied.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
