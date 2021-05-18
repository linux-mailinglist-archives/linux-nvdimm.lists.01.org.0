Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3A23882D9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 May 2021 00:42:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ECE1E100F2262;
	Tue, 18 May 2021 15:42:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D2101100F225C
	for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 15:42:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a25so13057303edr.12
        for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 15:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zu5GK23yJ6L2kBBaFGsagM6qn5wup77XOxyPy2gcO30=;
        b=K2swg+0EwseRLo3YyioxVuLG8XPm9IOxG27qagUePeT89zLlH37Uy42oTxb1aJDqIa
         5ioIxJX+I8oNwuN9b9gqg4y8fXOc8iBjc21MC/JWyi9KvE9Y+J9oFe3LJAHKcHDU65Wz
         6idsEByWRi1JyWyHAQ+ejXOb/ZHFuLwR2Qc9y8l8QUIoq9g+UJIClAUwl3Vau95oSkEm
         NdjcK9M6sbHZcm96FiE19Oo+uBgBru9/YD1zJweNaK+pPm8BB8Pn2ruMgdgetMpMtskR
         1hcSlC4yk3xESxBUwjbQ62cN7wqRMHAVpBHeLYu6bqIHNkJpn5+bhAlBqbm9D9H1ir3f
         9TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zu5GK23yJ6L2kBBaFGsagM6qn5wup77XOxyPy2gcO30=;
        b=NcLA23VorMIjdvVP58GALKG3q5lMxNdChl6h9OTYzZYmxzNvF/WT1MjflaW51AnlMq
         OoMtAy1+iPCgciO8xUojjqvt3GgJAxs+dnFLYf1fTi0dYh+LSdBXKkvuascGiNuALrbf
         coGiB6rwnWJMChBe72MDPwGitHGDqnv+3ZqHdKr28qrgHXymEmxY6D3BYKZJrUHu0Ek3
         91aKQitbAS64PJ/Rl4hfvNUu6wmA2KgL5S0dE+UvwqJCu7UiDy9k+WoxqNr7q87g5uTe
         QVAzh6exzQn0a8d+0R65Qe5DUSC4Imys+ul/GvCt9W9uYO2v2+iP6rEAXqQVJt4un/a+
         STsw==
X-Gm-Message-State: AOAM532L2sv2fVK3r4hHy+DJ5HnzrjqZqEDhtPpoQhPCRnOrs1uC49Oh
	0KfsFDGMCWIMB+iY7bPgMagUT2xEUeD1R85JDA1fSg==
X-Google-Smtp-Source: ABdhPJwSMNlakbf8hXUcE8GgwcgbPtYipaMyEu+Yx5fwcdC5pngMIqdnrYpBXKZ7FXVntdj1wiDkYqaQmcCmCpyno9w=
X-Received: by 2002:a50:fe8e:: with SMTP id d14mr9583314edt.97.1621377746185;
 Tue, 18 May 2021 15:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210518222527.550730-1-vishal.l.verma@intel.com>
In-Reply-To: <20210518222527.550730-1-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 18 May 2021 15:42:14 -0700
Message-ID: <CAPcyv4hfZBgtEW8iaJ1yu=E758hzErxiAre2Tk4cw7Fb0E=R=Q@mail.gmail.com>
Subject: Re: [ndctl PATCH] ndctl: Update nvdimm mailing list address
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: JZ3K5SEP3VJHV6I6G5ACYKMOBIB5IUMA
X-Message-ID-Hash: JZ3K5SEP3VJHV6I6G5ACYKMOBIB5IUMA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: nvdimm@lists.linux.dev, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JZ3K5SEP3VJHV6I6G5ACYKMOBIB5IUMA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 18, 2021 at 3:26 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> The 'nvdimm' mailing list has moved from lists.01.org to
> lists.linux.dev. Update CONTRIBUTING.md and configure.ac to reflect
> this.

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
