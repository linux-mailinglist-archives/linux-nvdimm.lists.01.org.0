Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FAD36E27A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Apr 2021 02:16:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 47BF6100EB325;
	Wed, 28 Apr 2021 17:16:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1043; helo=mail-pj1-x1043.google.com; envelope-from=maryclove123@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EB696100EB323
	for <linux-nvdimm@lists.01.org>; Wed, 28 Apr 2021 17:16:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so10008614pja.5
        for <linux-nvdimm@lists.01.org>; Wed, 28 Apr 2021 17:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=TvDH0Ufqq951p1SmGaor3zZZi0JBju1aRHwGT5Ex+6c=;
        b=QaD/VVOxxSHR992LoLrpIJQQds/+I56g/5Yghstb9fT9oxB4i1jHVKtKqdaKblE/VT
         itiQC65Rf+gWnNZ1ttu463nMM13UI4nP05lLbxGblTbKb6ISyL9STzgZzofKvlCx9HQ2
         N2kYxvrnae81cP6y+XVgJPvR02GdidKhbA+v+0fWcxhhQUp9iTg2DZddN16pOxZzNRqg
         cJizdYKQXjG73K611GqZYcEHJapZhctYriktf+3jTNHctQR/yKp0ioHbwTCu4Q6vmqy5
         m0JnwBmTlS+lybWS60ufhkYBXoIrCQLPLn/osKy7PI0vOMX8ytfB8SN+BlOR8ieCKrgr
         4e3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=TvDH0Ufqq951p1SmGaor3zZZi0JBju1aRHwGT5Ex+6c=;
        b=mNAfC9mupMWLDSVz3JiHuQnvX+yXkOX6DEDXGBqChtKjs2mVOoBR0JMHRW7dQRrvR0
         kgn6QSZUpYFfkxTC8am2QR4YcmWuzxAeCm25NihAjlN+lSvN7lO3SAN+YqXHXvP835RR
         GCuF8dMKLUAt2RLMco11c9+pQ1uxzHLTxjcXDaUko/Tz4+sF/zB9f6i3q4J+c1YFN7wV
         IomHQPS3Us0tZeuPOq/MIenjg88HRuNt/0KGdct6RGzacttvGb6N+h1R9hDrfxN272mq
         1TMO+cblPTLfhsTWUT643Sh+Fa1FbvjeveX6Ux8NUCYotyhGShScUJDzqj3SqG4MyVYj
         faPQ==
X-Gm-Message-State: AOAM530K3eNuz165x1H+/dlq9lO8UsXebwessEkloBc4ZQW5ibW/fEfg
	OTmWQxbcxE0oyw/8OoN+ivLL9SFjvV/AHjlmxI4=
X-Google-Smtp-Source: ABdhPJys50Z/YYYHza7YoZTIOfavd1KBVJXo4YzEpmXV8OuSslExnOqvEO4NfWPeWKrQGQ6nzlOBmh/CM8kWGT6bs78=
X-Received: by 2002:a17:902:bd0c:b029:ed:7018:4daf with SMTP id
 p12-20020a170902bd0cb02900ed70184dafmr6285423pls.67.1619655393335; Wed, 28
 Apr 2021 17:16:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:6426:b029:19:764e:b00a with HTTP; Wed, 28 Apr 2021
 17:16:32 -0700 (PDT)
From: Mr Kingsley Obiora <maryclove123@gmail.com>
Date: Thu, 29 Apr 2021 01:16:32 +0100
Message-ID: <CAFBdPme3gUvvM1J5pFQLKgBVdmORttJJz+vTj942PpKv5dUjHA@mail.gmail.com>
Subject: Hello From Dr Kingsley Obiora
To: undisclosed-recipients:;
Message-ID-Hash: CKFS7HMUSBQ2IZI4SFLZHGY3HSQZ6M2X
X-Message-ID-Hash: CKFS7HMUSBQ2IZI4SFLZHGY3HSQZ6M2X
X-MailFrom: maryclove123@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: bwalysam@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CKFS7HMUSBQ2IZI4SFLZHGY3HSQZ6M2X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Sir,

After our meeting held today based on your funds, the management want
to bring to your notice that we are making a special arrangement to
bring your said fund by cash through diplomatic Immunity to your
country home. Further details of this arrangement will be given to you
once you acknowledged this idea.

Waiting for your soonest response.
Kingsley Obiora
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
