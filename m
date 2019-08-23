Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8E59B55D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Aug 2019 19:22:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 90CD820215F53;
	Fri, 23 Aug 2019 10:25:10 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c42; helo=mail-yw1-xc42.google.com;
 envelope-from=rosie.huynh@autovalidinfo.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E432920215F42
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 10:25:08 -0700 (PDT)
Received: by mail-yw1-xc42.google.com with SMTP id w10so4090495ywa.13
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=autovalidinfo.com; s=google;
 h=mime-version:sender:from:date:message-id:subject:to;
 bh=fdlj3hC1Ut9R6g35aFMe9lwsldLnTQjlizOTfYRQxWk=;
 b=bQVHG/UEuMAEDcNzb7x6Lj96jilbNl4bUUF1e36ELWD70CRZEBfFHeBI3VR+WvsG3r
 e3vETh9RQW2fPGS1Ob76lopd7SuDzOkW9XMsZnx2TkFpryobSRhvrimaIDkNLm3b8c+E
 sbNvnt4Yks6xp3vn02Gx1UxfCITB9vp0T18+/tpy3wYv6Zu5ESMbgKInUIeVeO+0uW/i
 Cvd5m6BtviVylYQzhwnkNFOy7TS7eiEVn8eW223BVMmtplJffNADDpm2UvhuW8B38Nmx
 nggm6wkuC7SOh1H7dx7bQBmCx70u+4ZHrxCyIHRMqq1GD1xzsaspqbWmKmf4T8dINqJu
 sTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
 :to; bh=fdlj3hC1Ut9R6g35aFMe9lwsldLnTQjlizOTfYRQxWk=;
 b=ZhUrvg0doLwIL3KaO0uYaeAmE7lwVVjhRRvadKHNVWQfG06VKuv1DvyXR5TO1eeop3
 R3aR4n8dBq5EVayB21+KKxX8++nyfKcA1TY6dI5Qs5Dxgb/tDTLr89Z1f77r0Si4aWFl
 9qQD0LuFqhbBPl/lYh6aEmdrinLNu16lEwbC5B/bjFTtQugeiXQO44QeNH7rhplKPyE4
 zvweTHD1Y0+94AKRWbHboKc/uaq3cvqijMFfNDAuJD5lW4cAM6R4r4Iod52EMW1oF/UP
 FYyIGux9dcQBIYP9DTOOZieeXPb0r4wfvUc8Mt+EThDsG918pZssDRdH8BB90DUIeZTD
 UF0Q==
X-Gm-Message-State: APjAAAVJmmVkmrde3hWErc3B+iTwnPMLaHgyeIshKoRrinsSvjbKweAx
 /NgGADaJ/pJrZMCGVt8hWW7KtpDpXcbO5xDfneePjYlw
X-Google-Smtp-Source: APXvYqwlC5NwUujlwijJK2fFp+PRVIveP0nXW5sQUokQJ2+9+kfvpYJ/qSm8iLJlwHZ7uqgf9jXRmFI5pMm3xn65/TM=
X-Received: by 2002:a81:6f89:: with SMTP id k131mr4201254ywc.229.1566580947367; 
 Fri, 23 Aug 2019 10:22:27 -0700 (PDT)
Received: from 158059779194 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Aug 2019 10:22:26 -0700
MIME-Version: 1.0
From: rosie.huynh@autovalidinfo.com
Date: Fri, 23 Aug 2019 10:22:26 -0700
X-Google-Sender-Auth: YEBnX7o9crJiby-vtQ-Q7g1CKFs
Message-ID: <CAAJs2D6i_TTt0SV8KTtrBj=67=WBv_iDK__23XF6ni=AKzjyOQ@mail.gmail.com>
Subject: Managed Security Service Providers (MSPs & MSSPs)
To: linux-nvdimm@lists.01.org
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi,

Did you get a chance to review my below email? Kindly let me know your
requirements and I will get back with detailed information on the same.

Warm Regards,
Rosie Huynh
Marketing Manager
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
