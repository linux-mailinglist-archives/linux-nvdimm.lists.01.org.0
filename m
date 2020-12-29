Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF12B2E6D66
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Dec 2020 04:00:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 393B9100EF261;
	Mon, 28 Dec 2020 19:00:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::747; helo=mail-qk1-x747.google.com; envelope-from=3zjvqxxajdlmfkvanltdctbwxxv0zftbe.vhfebgnq-gowbffeblml.tu.hkz@trix.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x747.google.com (mail-qk1-x747.google.com [IPv6:2607:f8b0:4864:20::747])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C9F07100EF25B
	for <linux-nvdimm@lists.01.org>; Mon, 28 Dec 2020 19:00:30 -0800 (PST)
Received: by mail-qk1-x747.google.com with SMTP id y187so2221004qke.20
        for <linux-nvdimm@lists.01.org>; Mon, 28 Dec 2020 19:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:message-id:date:subject:from:to;
        bh=C3LODO2AZdlQMr2vg0RnTVVCsNdFzCjtKvymI0A+kwo=;
        b=kJK4J58V0sFMVosaP7wWA0It6qk2uHP4y5dalffOZAdFyL8LR89xXLC2ExMR8SRynU
         nbIbksuCTJN03ODR9O1OdPIu8CymHuabBdbDf9LaQp74/90Vl6c684m+PniPDzgM228P
         zZkOkGBDTe6bDW6S1/IXUideaHwaQ0JIvKkUQd6ohl+ySQPfTZc5bxG5nCbOuRfZBk3g
         VdZG/+HEQmxJz0lbyGQbjBbyuQdXuiwSCCldmc6yZfhwmNENMd8pt1rKkaszg5sKKvcC
         pzBJgvnuYnccuQeHXVC4wzzoa0jmhQpDOxltMEupSvzvtmI5/9cPJurMr9aKEyUHvNsi
         NQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:message-id:date:subject
         :from:to;
        bh=C3LODO2AZdlQMr2vg0RnTVVCsNdFzCjtKvymI0A+kwo=;
        b=nMG/kT993SK+TyuVenIq2oZVyBiqtk10mODe+bZP+WRpvCL4DYhXTEtuapPnCLfrkF
         0vYBa23LE8kndzQtEUDigg5/5fbTFbDIy0N0InCkOOE7yN1JqbwZiWYXJPzHDwUG0dp0
         lseANd84K5+quwqwygKqDk+orHEYf/ULs66mEDsRRdmPDe+Wb9BhqLoPHtQdn2WBnS8d
         Oa6ye1HZ/Z1g3OP9uN8BrGcY37I7+h5hy8ZU6k1pxnXHjoQQSFf/Pqronms3fEauTR0P
         Yc5VxAKdo+zo+sQwgPru+xn3AURU84/2r0gZZKjTONRB0WkJi/Rt34oqTaNVddKHNHk+
         /7FA==
X-Gm-Message-State: AOAM533ZbaQaWK8ZCVo8InGaJ/0VMJYPm0lhmqtOpSwZiy0EU+Yqny1O
	MckbZpqZAjAbo1gQoYUqAKQglcS5Sn3ojOqOl8kK
MIME-Version: 1.0
X-Received: by 2002:a05:6214:14af:: with SMTP id bo15mt50115942qvb.19.1609210828753;
 Mon, 28 Dec 2020 19:00:28 -0800 (PST)
X-No-Auto-Attachment: 1
Message-ID: <000000000000d11d7505b7919753@google.com>
Date: Tue, 29 Dec 2020 03:00:29 +0000
Subject: From Mrs.Ameena Essa.
From: mrchusakjaidee27@gmail.com
To: linux-nvdimm@lists.01.org
Message-ID-Hash: Q7JQYWBA5LA5OA2WUYHMUNCEVV3TUZ55
X-Message-ID-Hash: Q7JQYWBA5LA5OA2WUYHMUNCEVV3TUZ55
X-MailFrom: 3zJvqXxAJDLMfkVanlTdcTbWXXv0ZfTbe.Vhfebgnq-goWbffeblml.tu.hkZ@trix.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mrchusakjaidee27@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q7JQYWBA5LA5OA2WUYHMUNCEVV3TUZ55/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
Content-Transfer-Encoding: 7bit

I've invited you to fill in the following form:
Untitled form

To fill it in, visit:
https://docs.google.com/forms/d/e/1FAIpQLScR7VtgP7Zseg2CFyFt0jq76D1roEX5l-8qGSv94gy5rhZ4tQ/viewform?vc=0&amp;c=0&amp;w=1&amp;flr=0&amp;usp=mail_form_link

Good day.

My name is Mrs.Ameena Essa from Saudi Arabia. I am a widow suffering from  
Esophageal cancer, My cancer disease has defiled all forms of medical  
treatments. And according to my doctor, I have few months to live.But  
before I die, I want to donate my inherited ($10.7 Million dollars) to you  
so that you can use the money for humanitarian aid and charitable works,  
Including building of religious houses in your country or any country of  
your choice. I have also mapped out 20% of the total sum of $10.7 Million  
for you as a reward for your help in carrying out this task.

If you are interested in helping me carry out my last wish, please reply to  
this message to enable me to give you all the details.

Best Regards.
Mrs. Ameena Essa
Email: mrsameenae@gmail.com


Google Forms: Create and analyse surveys.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
