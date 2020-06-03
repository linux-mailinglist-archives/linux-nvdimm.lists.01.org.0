Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C704F1ED136
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jun 2020 15:48:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6D881100A6415;
	Wed,  3 Jun 2020 06:43:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com; envelope-from=mrsolivierk@gmail.com; receiver=<UNKNOWN> 
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9FEFA100F2260
	for <linux-nvdimm@lists.01.org>; Wed,  3 Jun 2020 06:43:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w15so1342694lfe.11
        for <linux-nvdimm@lists.01.org>; Wed, 03 Jun 2020 06:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=H8rDQEJouwBJIElP/Vpqq+PrvTZxQQy2H7A/MvyMMB0=;
        b=LImzFWfFZ5MGhzJT1qzCsgEXVo7xW37sUIdrDLCKiXHQE0/Tq0rYX6Af/ld5dvlhmE
         opFt8B8vUrhAfyxGIRs7eIQZmnu+cHCt7Dz4gEu/fnBWHDlMa8iVHDbM7XgqJUtNcgor
         I4Oj1yGJ3ygOniFn6Dr+FHDS5BV48N/ldz+eBwWbR5/ADnYCL6KuztRZu9mrKJOxMODU
         fmVICwwGmTYXXsgICTxE6unupuMdGq6+YZvkWKysZVLYK3Wwxrg7U2ecMo3WGycHWcU1
         w35jxyjuynpm30G3kj/I18A4vO2Y2WN0kfTajUkGc1Xe9t84eQuWhnB4AGlAS8dbrawc
         iC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=H8rDQEJouwBJIElP/Vpqq+PrvTZxQQy2H7A/MvyMMB0=;
        b=FfMlTp3Rjpfjucql95s2CwdvfIMzmWpXCxHBR7VrwT52Ogu1VKOnJSVIPz95BkYIEn
         VMShidPqruG7clHZR7chkywJdTCt4a6VBHlMSf1yJRYcFa1htCdOdn2IhhXOB3inW9B0
         cEyOA7ETmGHw6bYaIhzcLVTy+tA7MrTdfTzIywnNEJhSGlmJVH4R4wGOEjgZKquNVDFx
         q4xejqifQnLIGALiQeO9u7+izO90uti5jlvKvTOVLVBoiB1my8ZR/UlhxQ13qlWvDidv
         Ox7NmPniPzDzadQvPPqO9o08ZT13HFHCRAFiVCEKkK1w9Ziwvl4rJd3/hcwH2JFm3I2w
         S/1w==
X-Gm-Message-State: AOAM533WZzHCjUhyS0aRrDG8RGzy7GrShjG1KHltDcMAn+eoaUahBGuH
	z0X9YXQ9MAvEXRjqHfIUG3dIuDJaoy7FX/wGH6M=
X-Google-Smtp-Source: ABdhPJzc66PsPJ7uf2JiXrqj7zfh07Ra5BpBms0TPKeexmxkWkfXYY+ch/Os+E85wJbdOE6Lm+0ANdybV/7KRG4HAcU=
X-Received: by 2002:a05:6512:308e:: with SMTP id z14mr2566308lfd.29.1591192127287;
 Wed, 03 Jun 2020 06:48:47 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsolivierk@gmail.com
Received: by 2002:a19:a405:0:0:0:0:0 with HTTP; Wed, 3 Jun 2020 06:48:46 -0700 (PDT)
From: "Mrs.Susan Jones" <joneswife.susan@gmail.com>
Date: Wed, 3 Jun 2020 14:48:46 +0100
X-Google-Sender-Auth: aH2vam-ZraP3yG1gz3ryctMgTE4
Message-ID: <CALBhdBfusXWup1N4iFuTS3D1AZxWbZbTDS_qa-wA3FkbkE7MrQ@mail.gmail.com>
Subject: HELLO: I AM MRS SUSAN JONES
To: undisclosed-recipients:;
Message-ID-Hash: VXNC6YF2YSP3VF43QKHT3RQTZLP5V7U2
X-Message-ID-Hash: VXNC6YF2YSP3VF43QKHT3RQTZLP5V7U2
X-MailFrom: mrsolivierk@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: susanjones.wife@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VXNC6YF2YSP3VF43QKHT3RQTZLP5V7U2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

-- 
OUR GOLDEN OPPORTUNITY

Hello Dear Friend,

Complement of the day, i hope you are doing great today. However, I am
Mrs.Susan Jones, an auditor with one of the new generation banks here
in Burkina Faso.

I am writing you this letter based on the latest development at my
Department. i discovered some abandoned huge amount of money, Ten
Million, Five hundred thousand  United States Dollars.($10.500.000).
Now I am only contacting you as a foreigner because this money cannot
be approved to a local bank account here, but can only be approved to
any foreign account and foreign beneficiary because the money is in US
dollars

This will be  a legitimate transaction once you accept to build trust
with me and follow simple instruction doing the transfer process,
until the total sum transfer out of the bank here to your own bank
account any where in the world, and I agreed to share the total money
50/50 with you once you successful confirmed it in your bank account.
But any expenses doing the transfer process will be deduct from the
amount before sharing, If you are interested to work with me and
provide a good receiving bank account, get back to me as soon as
possible with the following details below.

Your full name
Your Profession
Your direct mobile phone number
Your Scanned International passport or any of your identity

NOTE: PLEASE IT YOU ARE NOT INTERESTED DON'T BORDER TO RESPOND BACK TO
AVOID TIME WASTED.

As soon as I receive these data's, I will forward to you the
application form which you will send to the bank for the claim and
transfer of the fund into your bank account as the  new beneficial.

I am waiting to hear from you soon

Yours
Mrs.Susan Jones
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
