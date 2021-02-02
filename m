Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971FC30B631
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 05:10:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D9E9F100EC1DF;
	Mon,  1 Feb 2021 20:10:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com; envelope-from=enbyamy@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 32FBD100EC1D4;
	Mon,  1 Feb 2021 20:10:07 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id d5so3182916otc.1;
        Mon, 01 Feb 2021 20:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=giiXVwDNBPzU24mUOhZBcf7qgrysWATGHSQcqUPBt6g=;
        b=f05waASbj1Ga26deTpzylfUQMkyyWS4/9hP6GiarCN5WbcSPYBVAcM0R5TKp/i7o6F
         4c5JQQSZ+F/kieLAvMEfuvn7STVM3e1mBCbMV5BNRtBUVib47l8I/Jt8bzsuni0Lpby2
         99P01gP3p+0IkEKV1Ks+b0qCrOjawNDXd2OLMR4jb7ykyUUXH2tQ+pl92gENDfliRpzc
         DBNBeG3CYnvS5/z/UOUQvwSyTcFa7x/x3/tVwtSCLP1JjPiA5PJ89KNStIowy565NLgO
         6VQbXz+vj3zNOPvpx1Ksuetc9FuwMIPQSZHANf26OItMYYXh1wSVsh7+Wi1iG/KSwCAF
         CvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=giiXVwDNBPzU24mUOhZBcf7qgrysWATGHSQcqUPBt6g=;
        b=kib1dwS1sM+P1jVjzHwR5FSBydx6aUPwEiG/z2U/k0jlJErcXfM0h6QRcEifxniLqJ
         C4RnXOczdn5f9Mjh4uvsY4eae5xHnN1Mv/s35YP4x3D57GIJHG8wErEqE70STGSb9OyI
         wK3kEzTEmgMrPTnBVHJ4IISrHBhYQ63TtGYHQbSsz2Ykghp8KDKSiq73nmIaxhfjPkUV
         K/9z4vW4PqPSrRcUE+GDoBnDDqOyfKT596YlYVlM+MyQvLgEznQL25IdFQWC1Q3pIJh8
         h0Aqe5ggIIx4x/dyi4P3tJH+gswxF5lb4bAVjc4E86HcoglyoJ7ew3rMBLxFzzEUxaRG
         pxfw==
X-Gm-Message-State: AOAM531JocDeQINogw52Wqy3QxZYj9CcX46XaKBnabvKxzsTSrQTdoK4
	jG6zeqVgRz7v4SwoQ6t8Aa43iEg0ksCKubRS3vGKPDLiKYU=
X-Google-Smtp-Source: ABdhPJye0g5Mw8gou7IRBm3+xs29Tynw/EWW+m+dFMk1puJbbo4+YaDhJ8k+cYQoIdO8621dHCGlKviYYgUIwrwALp4=
X-Received: by 2002:a05:6830:1b6b:: with SMTP id d11mr13844275ote.254.1612239006104;
 Mon, 01 Feb 2021 20:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20210201194210.93E92E537031187F@balaiworld.com>
In-Reply-To: <20210201194210.93E92E537031187F@balaiworld.com>
From: Amy Parker <enbyamy@gmail.com>
Date: Mon, 1 Feb 2021 20:09:55 -0800
Message-ID: <CAE1WUT7rPmEeZ6M1hFPB_NuqY72A9sZg3nJLmFzQg70LNoUhyQ@mail.gmail.com>
Subject: Re: PERT ENTERPRISES SWIFT - JAN. 29, 2021 PAYMENTS MADE BY RUSTAN'S
To: RAJENDRA BALAI ACCOUNT <export@balaiworld.com>
Message-ID-Hash: FRCK5WDTJ546PZTCAWZJTXIQNREHDMKS
X-Message-ID-Hash: FRCK5WDTJ546PZTCAWZJTXIQNREHDMKS
X-MailFrom: enbyamy@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, postmaster@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FRCK5WDTJ546PZTCAWZJTXIQNREHDMKS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 1, 2021 at 7:42 PM RAJENDRA BALAI ACCOUNT
<export@balaiworld.com> wrote:
>
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Can someone please block this account from the lists?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
