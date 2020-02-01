Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A9914F928
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Feb 2020 18:34:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB13E10FC3176;
	Sat,  1 Feb 2020 09:37:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B1301003E988
	for <linux-nvdimm@lists.01.org>; Sat,  1 Feb 2020 09:37:37 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id d62so10576900oia.11
        for <linux-nvdimm@lists.01.org>; Sat, 01 Feb 2020 09:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtlBGnOFdYatlABMmvX9Zn+TYTRXCztfhZYZ1Bz9w4U=;
        b=g0I5kOKxbvaIHoz9zzo8+TvveUAbR9LvXjkSIK9y9JEVS47kBiSJ1EyNJB4o1BRmii
         CvN63G1tQmqv0VVWKjeMITEWMK+GuXhhPLB0W7gY1V7O480ajxmJs60vGlwwqqscoZiU
         WnXN8o0/DlOss4B0Cgb+N7WBWoylZTHzhBXzJLT671I2qXqrL/+Ma+2z1qkX3SN4g56X
         ol8UpuFzah3PN49ABHPtj/QbML8z/NdOCZWOR/dHazQfTL277Ib9WdMhxCTVSvQZvBuR
         8at5WtKcymXUXEaX8DOGadlPCCtcbZT5dTTEh0SamIUltO8pPyIEHVjvhnu5dD+8Vws8
         AxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtlBGnOFdYatlABMmvX9Zn+TYTRXCztfhZYZ1Bz9w4U=;
        b=SwcjyC1k3uRkspr7/10zxosJCiW7pbvUZoLLW672IyMeiqVjlfCP5+f14tQvXYIv0k
         URbHgjFnv7hHgduVCx89q51MSrFtmH8HgpYSGMYvQrnaUIFEbWbcOpa8WnZRF7B7vfrl
         bFCcjsnMgpa5G4rhnJXF9wHZMJCVve4V8qTEhpwaB7JX5rYDg7jnoazq15Bu6UwggbsI
         QcGGd0iXyF8QCgd9MyJ7jXocHxONlVxm5Few2ZLy1wMXXnejzmeNFyxVEEyx8qI1auAH
         YdEaOqzCyaOXLroXzxoUb1uR7fpHy29ReyLMpFopqpgPIHfmGHl8sMOAB9O9LNi5lzkC
         1c4g==
X-Gm-Message-State: APjAAAXvR374dicInuJYIu8TqWq4GhXVacO62PEFKg4TEYVZNfg2KJCk
	pDdgc2yZk6jpJ2+qTwez7hw7CR44IFeik3QLNrXbmw==
X-Google-Smtp-Source: APXvYqwb5iv1ePTk/w/ExyS59Gep0ry7jVLVOw430odoGAVzf892BRwIV2FslFjJZkDioXv+xZpvSF/r4FdlRncJMSA=
X-Received: by 2002:a54:4791:: with SMTP id o17mr9472411oic.70.1580578456766;
 Sat, 01 Feb 2020 09:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20200201170933.924-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200201170933.924-1-lukas.bulwahn@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 1 Feb 2020 09:34:05 -0800
Message-ID: <CAPcyv4iP9AMrkNk-sabqCmS0bZkBcO5gx2tsv5kM0tFxjv_YTA@mail.gmail.com>
Subject: Re: [PATCH RFC] MAINTAINERS: clarify maintenance of nvdimm testing tool
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Message-ID-Hash: K3THTG4CD5AGZXZJW7DJA4M3GYPWRF6C
X-Message-ID-Hash: K3THTG4CD5AGZXZJW7DJA4M3GYPWRF6C
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K3THTG4CD5AGZXZJW7DJA4M3GYPWRF6C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Feb 1, 2020 at 9:09 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> The git history shows that the files under ./tools/testing/nvdimm are
> being developed and maintained by the LIBNVDIMM maintainers.
>
> This was identified with a small script that finds all files only
> belonging to "THE REST" according to the current MAINTAINERS file, and I
> acted upon its output.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> This is a RFC patch based on what I could see as an outsider to nvdimm.
> Dan, please pick this patch if it reflects the real responsibilities.
>
> applies cleanly on current master and next-20200131

Looks good, thanks, applied.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
